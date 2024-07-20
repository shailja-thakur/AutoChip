module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n 
);

	wire w1, w2;

	// Assign the value of the logical AND of inputs a and b to wire w1
	assign w1 = a & b;
	
	// Assign the value of the logical AND of inputs c and d to wire w2
	assign w2 = c & d;
	
	// Assign the value of the logical OR of wires w1 and w2 to output out
	assign out = w1 | w2;
	
	// Assign the logical NOT of the output out to output out_n
	assign out_n = ~out;

endmodule
