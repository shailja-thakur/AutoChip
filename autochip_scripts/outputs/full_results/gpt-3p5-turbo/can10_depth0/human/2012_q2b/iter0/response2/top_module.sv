module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State flip-flops
	reg [5:0] y_ff;
	always @(posedge w)
		y_ff <= y;

	// Output assignments
	assign Y1 = y_ff[1];
	assign Y3 = y_ff[3];

endmodule
