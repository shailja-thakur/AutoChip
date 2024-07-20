module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 0;
parameter B = 1;

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

always @(state, x) begin
	case (state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = A;
		end
		B: next_state = B;
	endcase

	if ((state == A && x) || (state == B && !x))
		z = 1;
	else
		z = 0;
end

endmodule
