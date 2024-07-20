module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	assign out = a & b | c & d;
	assign out_n = ~out;
	
endmodule
