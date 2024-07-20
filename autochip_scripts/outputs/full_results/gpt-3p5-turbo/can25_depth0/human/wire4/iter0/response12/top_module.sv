module top_module (
	input a,
	input b,
	input c,
	output w,
	output x,
	output y,
	output z  );

	wire w;
	assign w = a;

	wire x;
	assign x = b;

	wire y;
	assign y = b;

	wire z;
	assign z = c;

endmodule
