module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	parameter A = 1'b0;
	parameter B = 1'b1;

	reg state, next_state;

	always @(posedge clk or posedge reset)
		if (reset)
			state <= A;
		else
			state <= next_state;

	always @*
		begin
			case (state)
				A: if (j) next_state = B; else next_state = A;
				B: if (k) next_state = A; else next_state = B;
			endcase
		end

	assign out = (state == B);

endmodule
