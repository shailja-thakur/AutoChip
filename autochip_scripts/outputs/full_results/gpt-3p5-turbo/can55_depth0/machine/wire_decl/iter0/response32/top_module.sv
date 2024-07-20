module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire w1;
	wire w2;
	
	assign w1 = a & b; // logical AND of inputs a and b
	assign w2 = c & d; // logical AND of inputs c and d
	
	assign out = w1 | w2; // logical OR of wires w1 and w2
	assign out_n = ~out; // logical NOT of the output out
	
endmodule
