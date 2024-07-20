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
    // Define parameters
    parameter PHT_SIZE = 128;
    parameter INDEX_SIZE = 7;
    parameter PC_SIZE = 7;
    parameter HISTORY_SIZE = 7;

    // Declare internal signals
    reg [6:0] history_reg;
    reg [6:0] index;
    reg [1:0] pht[PHT_SIZE-1:0];

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_reg <= 0;
            predict_taken <= 0;
            predict_history <= 0;
        end else begin
            if (predict_valid) begin
                index <= predict_pc ^ history_reg;
                predict_taken <= (pht[index] == 2) || (pht[index] == 3);
                predict_history <= history_reg;
            end
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history_reg <= 0;
        end else begin
            if (train_valid) begin
                index <= train_pc ^ train_history;
                if (train_mispredicted) begin
                    pht[index] <= (pht[index] == 0) ? 0 : (pht[index] == 1) ? 0 : (pht[index] == 2) ? 1 : 2;
                    history_reg <= train_history;
                end else begin
                    pht[index] <= (train_taken) ? (pht[index] == 0) ? 0 : (pht[index] == 1) ? 1 : (pht[index] == 2) ? 2 : 3 : (pht[index] == 0) ? 0 : (pht[index] == 1) ? 0 : (pht[index] == 2) ? 1 : 2;
                    history_reg <= train_history;
                end
            end
        end
    end

endmodule
