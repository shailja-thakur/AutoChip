module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT [0:127];
    // 7-bit global branch history register
    reg [6:0] global_history;

    // Initialize PHT and global history register
    integer i;
    always @(posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly Not Taken initial state
            end
        end
    end

    // Predict interface
    always @(posedge clk) begin
        if (predict_valid) begin
            predict_history <= global_history;
            predict_taken <= (PHT[predict_pc ^ global_history] >= 2'b10);
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Training interface
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end
            // Update PHT based on actual outcome
            if (train_taken) begin
                if (PHT[train_pc ^ train_history] != 2'b11) begin
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
                end
            end else begin
                if (PHT[train_pc ^ train_history] != 2'b00) begin
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
                end
            end
        end
    end

    // Resolve conflicts between predict and train interfaces
    always @(posedge clk) begin
        if (train_valid && train_mispredicted) begin
            global_history <= {train_history[5:0], train_taken};
        end else if (predict_valid && ~train_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end
endmodule
