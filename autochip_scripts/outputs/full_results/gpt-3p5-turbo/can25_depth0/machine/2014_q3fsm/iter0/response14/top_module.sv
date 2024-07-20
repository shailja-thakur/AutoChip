module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(state or s or w) begin
	case (state)
		A: begin
			if (s)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		C: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		S10: begin
			if (w)
				next_state = S21;
			else
				next_state = S20;
		end
		S11: begin
			if (w)
				next_state = S22;
			else
				next_state = S21;
		end
		S20: next_state = B;
		S21: begin
			if (w)
				next_state = C;
			else
				next_state = B;
		end
		S22: begin
			if (w)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

always @(posedge clk) begin
	if (state == S10)
		z <= 1'b1;
	else
		z <= 1'b0;
end

endmodule
