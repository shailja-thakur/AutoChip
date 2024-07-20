module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    // Sum of minterms form derived from the Karnaugh map
    assign out = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (~a & b & ~c & d) | 
                 (~a & b & c & ~d) | (~a & b & c & d) | (a & ~b & ~c & ~d) | (a & ~b & ~c & d) | 
                 (a & b & c & ~d) | (a & b & c & d) | (a & b & ~c & ~d);

endmodule
