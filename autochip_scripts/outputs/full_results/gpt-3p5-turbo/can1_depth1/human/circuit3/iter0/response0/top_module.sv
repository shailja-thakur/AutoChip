module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

	// Combined logic expression for q
	assign q = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) | (~a & b & ~c & ~d) | (a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d);

endmodule
