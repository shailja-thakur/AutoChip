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
    reg [1:0] pht [0:127]; // Pattern History Table of 128 entries of 2-bit counters
    reg [6:0] global_history; // 7-bit global branch history register
    integer i;
    
    // Initialize branch history register and pattern history table
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                pht[i] <= 2'b01; // Weakly not taken by default
        end
    end
    
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;
    
    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid) begin
            case (pht[predict_index])
                2'b00, 2'b01: predict_taken <= 1'b0; // Predict not taken
                2'b10, 2'b11: predict_taken <= 1'b1; // Predict taken
            endcase
            predict_history <= global_history;

            // Update global history with the predicted taken/not-taken branch
            global_history <= {global_history[5:0], predict_taken};
        end

        // Training logic
        if (train_valid) begin
            // Recover global history if there was a misprediction
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end

            // Update the PHT entry based on the actual branch outcome
            case (train_taken)
                1'b0: begin
                    if (pht[train_index] > 0) pht[train_index] <= pht[train_index] - 1;
                end
                1'b1: begin
                    if (pht[train_index] < 3) pht[train_index] <= pht[train_index] + 1;
                end
            endcase
        end
    end
    
endmodule
