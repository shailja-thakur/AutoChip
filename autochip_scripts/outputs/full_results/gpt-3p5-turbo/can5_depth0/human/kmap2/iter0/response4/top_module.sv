module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	/* 
	Truth Table:
	ab | cd | out
	---------
	00 | 00 |  1
	00 | 01 |  1
	00 | 11 |  0
	00 | 10 |  1
	01 | 00 |  1
	01 | 01 |  0
	01 | 11 |  0
	01 | 10 |  1
	11 | 00 |  0
	11 | 01 |  1
	11 | 11 |  1
	11 | 10 |  1
	10 | 00 |  1
	10 | 01 |  1
	10 | 11 |  0
	10 | 10 |  0
	*/
	
	// Implementing the Karnaugh map
	assign out = (~a & c & ~d) | (a & ~b & ~c & ~d) | (a & ~b & c & ~d) | (a & b & ~c & ~d);
	
endmodule
