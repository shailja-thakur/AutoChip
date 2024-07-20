module top_module (
	input a,
	input b,
	input c,
	output w,
	output x,
	output y,
	output z  );

	// internal wire connections
	wire tmp_b;

	// connections
	assign w = a;
	assign x = b;
	assign y = b;
	assign z = c;
endmodule
