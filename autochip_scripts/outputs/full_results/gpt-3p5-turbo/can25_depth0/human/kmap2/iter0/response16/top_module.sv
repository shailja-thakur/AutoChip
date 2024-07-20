module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Declare intermediate signals
wire w1, w2, w3, w4;

// Implement the logic based on the Karnaugh map
assign w1 = (a & ~c) | (~a & c);
assign w2 = (d & ~b) | (~d & b);
assign w3 = (a & ~d) | (~a & d);
assign w4 = (b & ~c) | (~b & c);

assign out = w1 & w2 & w3 & w4;

endmodule
