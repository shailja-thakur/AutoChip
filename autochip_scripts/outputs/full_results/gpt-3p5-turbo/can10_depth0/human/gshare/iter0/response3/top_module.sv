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

reg [6:0] history_register;
reg [6:0] next_history_register;
reg [6:0] pht_index;
wire [6:0] predict_history;
wire predict_taken;

reg [127:0] pht [0:127];
reg [1:0] pht_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		history_register <= 0;
		pht <= 0;
		pht_state <= 0;
	end else begin
		history_register <= next_history_register;
		if (train_valid) begin
			next_history_register <= train_history;
			if (train_mispredicted) begin
				pht_index <= train_pc ^ history_register;
			end
		end else if (predict_valid) begin
			pht_index <= predict_pc ^ history_register;
		end
	end
end

assign predict_history = history_register;

assign predict_taken = (pht[pht_index] == 2 || pht[pht_index] == 3);

always @(posedge clk or posedge areset) begin
	if (areset) begin
		pht <= 0;
		pht_state <= 0;
	end else begin
		if (train_valid) begin
			if (train_mispredicted) begin
				pht[pht_index] <= 0;
			end else begin
				if (train_taken) begin
					if (pht[pht_index] < 3) begin
						pht[pht_index] <= pht[pht_index] + 1;
					end
				end else begin
					if (pht[pht_index] > 0) begin
						pht[pht_index] <= pht[pht_index] - 1;
					end
				end
			end
		end
	end
end

endmodule
