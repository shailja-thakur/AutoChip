module top_module (
	input a,
	input b,
	input c,
	output w,
	output x,
	output y,
	output z  );

	wire wire_a;
	wire wire_b;
	wire wire_c;

	assign wire_a = a;
	assign wire_b = b;
	assign wire_c = c;

	assign w = wire_a;
	assign x = wire_b;
	assign y = wire_b;
	assign z = wire_c;
endmodule
