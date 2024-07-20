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

reg [126:0] pht; // Pattern History Table
reg [6:0] bhr; // Branch History Register

reg predict_taken_r; // Predicted taken signal
reg [6:0] predict_history_r; // Predicted history register

always @(posedge clk or posedge areset) begin
    if (areset) begin 
        bhr <= 7'b0; // Reset the branch history register
    end else if (predict_valid) begin
        predict_taken_r <= pht[predict_pc ^ bhr];
        predict_history_r <= bhr;
    end else if (train_valid) begin
        if (train_mispredicted) begin
            pht[train_pc ^ train_history] <= $signed(pht[train_pc ^ train_history]) - 1;
        end else begin
            pht[train_pc ^ train_history] <= $signed(pht[train_pc ^ train_history]) + 1;
        end
        bhr <= train_history;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_taken <= 1'b0; // Reset predicted taken signal
        predict_history <= 7'b0; // Reset predicted history register
    end else begin
        predict_taken <= predict_taken_r;
        predict_history <= predict_history_r;
    end
end

endmodule
