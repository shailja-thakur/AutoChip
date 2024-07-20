module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// state A: If s is asserted, next state is B
reg next_state;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		next_state <= B;
	end else begin
		if (s) begin
			next_state <= B;
		end else begin
			if (w) begin
				next_state <= S11;
			end else begin
				next_state <= S10;
			end
		end
	end
end

// state B: If w is asserted, next state is S11, otherwise next state is S10
reg state_B_output;
always @(posedge clk) begin
	if (next_state == B) begin
		if (w) begin
			state_B_output <= 1'b1;
		end else begin
			state_B_output <= 1'b0;
		end
	end
end

// state C: If w is asserted, next state is S11, otherwise next state is S10
reg state_C_output;
always @(posedge clk) begin
	if (next_state == C) begin
		if (w) begin
			state_C_output <= 1'b1;
		end else begin
			state_C_output <= 1'b0;
		end
	end
end

// state S10: If w is asserted, next state is S21, otherwise next state is S20
reg state_S10_output;
always @(posedge clk) begin
	if (next_state == S10) begin
		if (w) begin
			state_S10_output <= 1'b1;
		end else begin
			state_S10_output <= 1'b0;
		end
	end
end

// state S11: If w is asserted, next state is S22, otherwise next state is S21
reg state_S11_output;
always @(posedge clk) begin
	if (next_state == S11) begin
		if (w) begin
			state_S11_output <= 1'b1;
		end else begin
			state_S11_output <= 1'b0;
		end
	end
end

// state S20: next state is B
always @(posedge clk) begin
	if (next_state == S20) begin
		next_state <= B;
	end
end

// state S21: If w is asserted, next state is C, otherwise next state is B
always @(posedge clk) begin
	if (next_state == S21) begin
		if (w) begin
			next_state <= C;
		end else begin
			next_state <= B;
		end
	end
end

// state S22: If w is asserted, next state is B, otherwise next state is C
always @(posedge clk) begin
	if (next_state == S22) begin
		if (w) begin
			next_state <= B;
		end else begin
			next_state <= C;
		end
	end
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		z <= 1'b0;
	end else begin
		if (state_B_output) begin
			z <= 1'b1;
		end else begin
			z <= 1'b0;
		end
	end
end

endmodule
