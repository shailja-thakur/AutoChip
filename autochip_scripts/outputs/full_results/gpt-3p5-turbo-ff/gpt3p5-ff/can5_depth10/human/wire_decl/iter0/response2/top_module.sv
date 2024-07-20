module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	assign intermediate1 = a & b;
	assign intermediate2 = c & d;
	assign out = intermediate1 | intermediate2;
	assign out_n = ~out;

endmodule
