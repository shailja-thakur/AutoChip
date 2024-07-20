module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Instantiating full adders
	wire [4:0] carry; // carry bits between full adders
	wire [3:0] sum_bits; // sum bits from each full adder

	full_adder fa0(x[0], y[0], 1'b0, sum_bits[0], carry[1]);
	full_adder fa1(x[1], y[1], carry[1], sum_bits[1], carry[2]);
	full_adder fa2(x[2], y[2], carry[2], sum_bits[2], carry[3]);
	full_adder fa3(x[3], y[3], carry[3], sum_bits[3], carry[4]);
	
	// Assigning output sum
	assign sum = {carry[4], sum_bits};

endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output s,
	output c_out
);
	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) | (b & c_in) | (c_in & a);
endmodule
