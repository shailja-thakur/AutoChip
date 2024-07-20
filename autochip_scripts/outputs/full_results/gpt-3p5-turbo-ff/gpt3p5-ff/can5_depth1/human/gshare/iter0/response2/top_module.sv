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
    // Define the parameters
    parameter INDEX_WIDTH = 7;
    parameter HISTORY_WIDTH = 7;
    parameter TABLE_SIZE = 128;
    parameter COUNTER_WIDTH = 2;

    // Define the variables
    reg [INDEX_WIDTH-1:0] index;
    reg [HISTORY_WIDTH-1:0] history_register;
    reg [TABLE_SIZE-1:0][COUNTER_WIDTH-1:0] table;

    // Reset the predictor
    always @(posedge areset) begin
        {index, history_register, table} <= 0;
    end

    // Make predictions
    always @(posedge clk) begin
        if (predict_valid) begin
            index <= predict_pc ^ history_register;
            predict_taken <= table[index] >= 2;
            predict_history <= history_register;
        end
    end

    // Train the predictor
    always @(posedge clk) begin
        if (train_valid) begin
            index <= train_pc ^ train_history;
            if (train_mispredicted) begin
                history_register <= train_history;
            end
            table[index][train_taken ? 1 : 0] <= table[index][train_taken ? 1 : 0] + (train_mispredicted ? -1 : 1);
        end
    end
endmodule
