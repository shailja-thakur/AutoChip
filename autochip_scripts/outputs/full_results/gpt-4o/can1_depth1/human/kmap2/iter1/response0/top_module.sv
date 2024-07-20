module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    // Simplifying the boolean function derived from the Karnaugh map.
    // The boolean function for the given K-map is:
    // out = !c!d + !a!b!c + !a!bc + !ab!d + abcd
    assign out = (~c & ~d) | (~a & ~b & ~c) | (~a & b & ~c) | (~a & b & ~d) | (a & b & c & d);

endmodule
