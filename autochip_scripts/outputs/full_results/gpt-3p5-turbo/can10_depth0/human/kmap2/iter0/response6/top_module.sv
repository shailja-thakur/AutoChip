module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define intermediate signals
wire w1, w2;

// Implement the Karnaugh map
assign w1 = (a & c) | (b & ~c);
assign w2 = (d & ~a & ~b) | (~d & a & ~b) | (~d & ~a & b) | (d & a & b);
assign out = (w1 & ~w2) | (~w1 & w2);

endmodule
