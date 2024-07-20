module top_module (
	input wire a,
	input wire b,
	input wire c,
	input wire d,
	output wire out,
	output wire out_n );

	wire w1;
	wire w2;

	assign w1 = a & b;
	assign w2 = c & d;

	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
