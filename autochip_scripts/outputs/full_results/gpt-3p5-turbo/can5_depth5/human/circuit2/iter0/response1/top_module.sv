module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Implementing the circuit using logic gates

    assign q = ~((a & b & ~c) | (~a & c & d) | (~a & ~b & ~d));

endmodule
