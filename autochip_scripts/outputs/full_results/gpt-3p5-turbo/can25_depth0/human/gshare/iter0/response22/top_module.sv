module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    // Constants
    parameter INDEX_SIZE = 7;
    parameter HISTORY_SIZE = 7;
    parameter TABLE_SIZE = 128;
    
    // Registers
    reg [INDEX_SIZE-1:0] index;
    reg [HISTORY_SIZE-1:0] history;
    reg [1:0] prediction;
    
    // Pattern History Table (PHT)
    reg [1:0] pht[TABLE_SIZE-1:0];
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset registers
            index <= 0;
            history <= 0;
            prediction <= 0;
        end else begin
            // Update index using XOR of pc and history
            index <= predict_pc ^ history;
            
            // Make prediction based on PHT value for corresponding index
            if (predict_valid) begin
                predict_taken <= pht[index] >= 2;
                predict_history <= history;
            end
            
            // Train PHT
            if (train_valid) begin
                pht[index] <= train_mispredicted ? (pht[index] > 0 ? pht[index] - 1 : pht[index]) : (pht[index] < 3 ? pht[index] + 1 : pht[index]);
                history <= {history[HISTORY_SIZE-2:0], train_taken};
            end
        end
    end
endmodule
