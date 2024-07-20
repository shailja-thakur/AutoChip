module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Implementing the circuit described by the Karnaugh map

// Creating the intermediate signals
wire w1;
wire w2;
wire w3;

// Implementing the logic for signal w1
assign w1 = ~(a & ~c);

// Implementing the logic for signal w2
assign w2 = b & c;

// Implementing the logic for signal w3
assign w3 = (a & b) | (a & c) | (b & c);

// Assigning the output
assign out = w1 | w2 | w3;

endmodule
