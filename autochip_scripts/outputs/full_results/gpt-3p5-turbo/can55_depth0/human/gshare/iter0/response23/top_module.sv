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

    reg [6:0] branch_history_register;
    reg [6:0] index;
    reg [1:0] pht [0:127];

    initial begin
        branch_history_register = 0;
        index = 0;
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] = 2'b00;
        end
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            branch_history_register <= 0;
        end else if (predict_valid) begin
            index <= (predict_pc ^ branch_history_register) & 7'b1111111;
            predict_taken <= (pht[index] == 2'b11) ? 1 : 0;
            predict_history <= branch_history_register;
        end else if (train_valid) begin
            index <= (train_pc ^ train_history) & 7'b1111111;
            pht[index] <= (train_mispredicted) ? (pht[index] > 0) ? (pht[index] - 1) : pht[index] : (pht[index] < 3) ? (pht[index] + 1) : pht[index];
            branch_history_register <= train_history;
        end
    end
endmodule
