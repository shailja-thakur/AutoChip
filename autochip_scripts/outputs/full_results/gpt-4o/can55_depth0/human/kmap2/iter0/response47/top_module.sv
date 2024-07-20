module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Using the Karnaugh map, we can derive the canonical Sum of Products (SOP) form:
	// out = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) | 
	//       (~a & b & c & d) | (a & b & c & ~d) | (a & b & ~c & d) | (a & b & ~c & ~d) |
	//       (a & ~b & ~c & ~d) | (a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & b & c & ~d)

	assign out = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) |
	             (~a & b & ~c & ~d) | (~a & b & c & d) | (a & ~b & ~c & ~d) | (a & ~b & c & ~d) |
	             (a & b & ~c & ~d) | (a & b & ~c & d) | (a & b & c & ~d);

endmodule
