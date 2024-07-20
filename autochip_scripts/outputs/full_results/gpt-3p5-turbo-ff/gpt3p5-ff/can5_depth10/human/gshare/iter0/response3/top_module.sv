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

    reg [6:0] g_history;
    reg [6:0] index;
    reg [1:0] pht [0:127];
    reg train_access;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            g_history <= 0;
            index <= 0;
            pht <= 0;
        end else begin
            if (train_valid) begin
                index <= train_pc ^ g_history;
                if (train_mispredicted) begin
                    g_history <= train_history;
                end
            	pht[index] <= pht[index] + (train_taken ? 1 : -1);
                train_access <= 1;
            end else if (predict_valid) begin
                index <= predict_pc ^ g_history;
                predict_taken <= (pht[index] >= 2);
                predict_history <= g_history;
                train_access <= 0;
            end
        end
    end
endmodule
