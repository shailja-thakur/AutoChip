module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
	// Evaluating the required logic from the given waveform, we can infer the following truth table:
	// a b c d | q
	// 0 0 0 0 | 0
	// 0 0 0 1 | 0
	// 0 0 1 0 | 0
	// 0 0 1 1 | 0
	// 0 1 0 0 | 0
	// 0 1 0 1 | 1
	// 0 1 1 0 | 1
	// 0 1 1 1 | 1
	// 1 0 0 0 | 0
	// 1 0 0 1 | 1
	// 1 0 1 0 | 1
	// 1 0 1 1 | 1
	// 1 1 0 0 | 0
	// 1 1 0 1 | 1
	// 1 1 1 0 | 1
	// 1 1 1 1 | 1
	
	// Implementing the logic from the truth table
	
	assign q = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & b & c) | (a & b & ~c & d) | (a & b & c);

endmodule
