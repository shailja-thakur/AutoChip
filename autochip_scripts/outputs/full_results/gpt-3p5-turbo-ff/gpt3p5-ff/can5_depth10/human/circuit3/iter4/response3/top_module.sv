module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal signals
	wire w1, w2, w3, w4, w5, w6, w7, w8;

	// Assign intermediate signals
	assign w1 = a & b;
	assign w2 = c & d;
	assign w3 = c & ~d;
	assign w4 = ~b & ~c;
	assign w5 = ~b & c;
	assign w6 = ~c & d;
	assign w7 = ~b & ~d;
	assign w8 = ~w2 & ~w3;

	// Assign output q based on intermediate signals
	assign q = ~(w1 | w4) & ~(w5 | w6) & ~(w7 | w8);

endmodule
