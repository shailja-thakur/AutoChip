module top_module (
	input a,
	input b,
	input c,
	output w,
	output x,
	output y,
	output z
);

	assign w = a;       // Assign input a to output w
	assign x = b;       // Assign input b to output x
	assign y = b;       // Assign input b to output y
	assign z = c;       // Assign input c to output z

endmodule
