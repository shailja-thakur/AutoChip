module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// states
	parameter A = 0;
	parameter B = 1;
	reg state;

	// default state
	initial begin
		state = A;
	end

	// state transition
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else if (state == A)
			state <= j ? B : A;
		else if (state == B)
			state <= k ? A : B;
	end

	// output assignment
	always @(state) begin
		out = (state == B) ? 1'b1 : 1'b0;
	end

endmodule
