module top_module (
	input a,
	input b,
	input c,
	input d,
	output [1:0] out,
	output [1:0] out_n );

	wire [1:0] w1, w2;

	assign w1 = a & b;
	assign w2 = c & d;
	assign out = w1 | w2;
	assign out_n = ~out;

endmodule
