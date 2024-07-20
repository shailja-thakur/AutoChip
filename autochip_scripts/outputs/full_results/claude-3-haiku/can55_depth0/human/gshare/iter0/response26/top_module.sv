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

// Hash function to get 7-bit index from 7-bit PC and 7-bit global history
function [6:0] hash_index(input [6:0] pc, input [6:0] history);
    hash_index = pc ^ history;
endfunction

// 2-bit saturating counter
reg [1:0] pht [127:0];

initial begin
    for (integer i = 0; i < 128; i++) begin
        pht[i] = 2'b10; // Initialize all counters to weakly taken
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_taken <= 0;
        predict_history <= 0;
        for (integer i = 0; i < 128; i++) begin
            pht[i] <= 2'b10;
        end
    end
    else begin
        // Prediction
        if (predict_valid) begin
            // Hash PC and history to get index
            integer index = hash_index(predict_pc, predict_history);
            // Get prediction from PHT
            predict_taken <= (pht[index] >= 2'b10);
            // Update branch history register
            predict_history <= {predict_history[5:0], predict_taken};
        end

        // Training
        if (train_valid) begin
            // Hash PC and history to get index
            integer index = hash_index(train_pc, train_history);
            // Update PHT based on actual branch outcome
            if (train_taken) begin
                if (pht[index] != 2'b11) pht[index] <= pht[index] + 1'b1;
            end
            else begin
                if (pht[index] != 2'b00) pht[index] <= pht[index] - 1'b1;
            end
            // If mispredicted, recover branch history register
            if (train_mispredicted) begin
                predict_history <= train_history;
            end
        end
    end
end

endmodule
