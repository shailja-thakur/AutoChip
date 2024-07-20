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

    reg [1:0] PHT [127:0];
    reg [6:0] global_history;

    integer i;

    // Initialize PHT and global_history
    always @(posedge areset) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly taken initial state
            end
            global_history <= 7'b0;
        end
    end

    // Predict logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Do nothing, reset is handled above
        end else if (predict_valid) begin
            predict_history <= global_history;
            predict_taken <= (PHT[predict_pc ^ global_history] >= 2'b10);
        end
    end

    // Update global history on prediction
    always @(posedge clk) begin
        if (~areset && predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Train logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Do nothing, reset is handled above
        end else if (train_valid) begin
            reg [6:0] index;
            index <= train_pc ^ train_history;

            // Train the PHT entry
            if (train_taken) begin
                if (PHT[index] < 2'b11) begin
                    PHT[index] <= PHT[index] + 1;
                end
            end else begin
                if (PHT[index] > 2'b00) begin
                    PHT[index] <= PHT[index] - 1;
                end
            end

            // Recover global history if mispredicted
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end
        end
    end
endmodule
