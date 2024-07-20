module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
    // Implementing the boolean function derived from the Karnaugh map.
    // out = !a&((!b&!d) | (b&!c) | (b&c&d) | (!b&c&!d)) | (a&((!b&!c&d) | (b&!c&!d) | (b&c&d)))
    assign out =   (~a & ((~b & ~d) | (b & ~c) | (b & c & d) | (~b & c & ~d))) 
                 | (a & ((~b & ~c & d) | (b & ~c & ~d) | (b & c & d)));
endmodule
