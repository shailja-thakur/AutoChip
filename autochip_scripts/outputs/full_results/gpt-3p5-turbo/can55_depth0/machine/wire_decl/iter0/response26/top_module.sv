module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

// Declare wires
wire w1, w2;

// Assign values to w1 and w2
assign w1 = a & b;
assign w2 = c & d;

// Assign value to out
assign out = w1 | w2;

// Assign value to out_n
assign out_n = ~out;

endmodule
