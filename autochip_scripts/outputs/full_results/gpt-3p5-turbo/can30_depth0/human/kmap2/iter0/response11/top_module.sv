module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define internal signals
wire w1, w2, w3;

// Implement the logic for the Karnaugh map
assign w1 = ~(~a & ~c) & d;
assign w2 = (~a & ~b) | (a & c);
assign w3 = (~a & b & ~d) | (a & ~c & ~d);

// Assign the output based on the logic
assign out = w1 | w2 | w3;

endmodule
