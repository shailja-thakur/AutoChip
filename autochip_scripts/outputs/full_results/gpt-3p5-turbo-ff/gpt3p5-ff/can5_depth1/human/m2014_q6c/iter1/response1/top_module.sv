module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);
	// Internal signals
	reg a_next, b_next, c_next, d_next, e_next, f_next;

	always @* begin
		// Next-state logic equations
		a_next = y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | y[1] & y[2] & y[3] & ~y[4] & ~y[5] & ~y[6];
		b_next = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | y[1] & ~y[2] & ~y[3] & y[4] & ~y[5] & ~y[6];
		c_next = ~y[1] & y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | ~y[1] & ~y[2] & ~y[3] & y[4] & ~y[5] & ~y[6];
		d_next = ~y[1] & y[2] & ~y[3] & y[4] & ~y[5] & ~y[6] | y[1] & y[2] & y[3] & ~y[4] & ~y[5] & ~y[6] | ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
		e_next = ~y[1] & ~y[2] & y[3] & ~y[4] & ~y[5] & ~y[6] | ~y[1] & y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
		f_next = ~y[1] & y[2] & ~y[3] & ~y[4] & y[5] & ~y[6] | ~y[1] & ~y[2] & ~y[3] & y[4] & y[5] & ~y[6];
	end

	always @(posedge w) begin
		// Output logic equations
		Y2 <= y[2] & ~w | a_next & w;
		Y4 <= y[4] & ~w | c_next & w;
	end
endmodule
