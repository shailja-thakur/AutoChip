module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;
parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

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
				next_state = state;
		end
		B, C: begin
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
		S20: begin
			next_state = B;
		end
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
		default: next_state = A; // Default case added to handle uninitialized state
	endcase
end

always @(posedge clk) begin
	if (reset)
		z <= 0;
	else begin
		if (state == S20)
			z <= 1;
		else
			z <= 0;
	end
end

endmodule
