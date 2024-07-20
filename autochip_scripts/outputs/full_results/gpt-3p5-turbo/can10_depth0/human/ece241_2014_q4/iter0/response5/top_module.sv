module top_module (
	input clk,
	input x,
	output reg z
);

	reg d1, d2, d3;
	wire xor_input, xor_output;
	wire and_input, and_output;
	wire or_input, or_output;

	assign xor_input = x ^ d1;
	assign and_input = x & ~d2;
	assign or_input = x | ~d3;
	
	dff dff1(.clk(clk), .d(xor_input), .q(d1));
	dff dff2(.clk(clk), .d(and_input), .q(d2));
	dff dff3(.clk(clk), .d(or_input), .q(d3));

	assign xor_output = xor_input ^ d1;
	assign and_output = and_input & ~d2;
	assign or_output = or_input | ~d3;
	assign z = xor_output ^ and_output ^ or_output;

endmodule
