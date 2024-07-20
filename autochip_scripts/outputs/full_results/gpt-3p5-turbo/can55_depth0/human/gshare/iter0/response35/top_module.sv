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

reg [6:0] global_history;
reg [6:0] pht_index;
reg [1:0] pht_entry;

reg predict_taken;
reg [6:0] predict_history;

reg [6:0] train_pc_reg;
reg train_valid_reg;
reg train_taken_reg;
reg train_mispredicted_reg;
reg [6:0] train_history_reg;

reg [6:0] next_pc;
reg next_valid;

// State machine states
parameter IDLE = 0;
parameter PREDICT = 1;
parameter TRAIN = 2;

reg [1:0] state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= IDLE;
	else
		state <= next_state;
end

always @(posedge clk or posedge areset) begin
	if (areset)
		global_history <= 0;
	else if (state == PREDICT)
		global_history <= {global_history[5:0], predict_taken};
	else if (state == TRAIN)
		global_history <= {global_history[5:0], train_taken_reg};
end

always @(posedge clk or posedge areset) begin
	if (areset)
		pht_index <= 0;
	else if (state == PREDICT)
		pht_index <= predict_pc ^ global_history;
	else if (state == TRAIN)
		pht_index <= train_pc_reg ^ train_history_reg;
end

always @(posedge clk or posedge areset) begin
	if (areset)
		pht_entry <= 0;
	else if (state == PREDICT)
		pht_entry <= pht_table[pht_index];
	else if (state == TRAIN)
		pht_entry <= pht_table[pht_index];
end

always @(posedge clk or posedge areset) begin
	if (areset)
		pht_table <= 0;
	else if (state == PREDICT)
		pht_table[pht_index] <= pht_entry;
	else if (state == TRAIN)
		pht_table[pht_index] <= next_pht_entry;
end

always @(posedge clk or posedge areset) begin
	if (areset)
		{predict_taken, predict_history} <= 0;
	else if (state == PREDICT) begin
		{predict_taken, predict_history} <= {pht_entry[1], global_history};
	end
end

always @(posedge clk) begin
	next_state = state;
	next_pc = predict_pc;
	next_valid = predict_valid;

	if (state == PREDICT) begin
		if (predict_valid && predict_pc != next_pc)
			next_state = IDLE;
	end else if (state == TRAIN) begin
		if (train_valid && train_pc_reg != next_pc)
			next_state = IDLE;
	end else if (state == IDLE) begin
		if (train_valid)
			next_state = TRAIN;
		else if (predict_valid)
			next_state = PREDICT;
	end

	if (state == PREDICT) begin
		if (predict_valid && predict_pc == next_pc)
			next_valid = 0;
	end else if (state == TRAIN) begin
		if (train_valid && train_pc_reg == next_pc)
			next_valid = 0;
	end
end

always @(posedge clk or posedge areset) begin
	if (areset)
		{train_pc_reg, train_valid_reg, train_taken_reg, train_mispredicted_reg, train_history_reg} <= 0;
	else if (state == TRAIN) begin
		{train_pc_reg, train_valid_reg, train_taken_reg, train_mispredicted_reg, train_history_reg} <= {train_pc, train_valid, train_taken, train_mispredicted, train_history};
	end
end

endmodule
