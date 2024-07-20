module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Karnaugh map:
//        a
// bc   0 1 
//  00 | 0 | 1 |
//  01 | 1 | 1 | 
//  11 | 1 | 1 | 
//  10 | 1 | 1 | 

// Logic equation: 
// out = a + b + c

assign out = a | b | c;

endmodule
