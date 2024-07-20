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

    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global history register
    integer i;

    // Initialize the pattern history table and global history register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly not taken state
            end
            global_history <= 7'b0;
        end
    end

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid && !train_valid) begin
            predict_history <= global_history;
            predict_taken <= (PHT[predict_pc ^ global_history] >= 2'b10);
            global_history <= {global_history[5:0], predict_taken}; // Update global history
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            // Update the PHT based on the train_pc and train_history
            if (train_taken) begin
                if (PHT[train_pc ^ train_history] < 2'b11)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
            end else begin
                if (PHT[train_pc ^ train_history] > 2'b00)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
            end

            // Recover global history if there was a misprediction
            if (train_mispredicted) begin
                global_history <= {train_history[6:1], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken}; // Update global history
            end
        end
    end

endmodule
