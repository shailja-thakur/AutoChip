module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Truth table
	
	// a  |  b  |  c  |  d  |  out
	// -----------------------------
	// 0  |  0  |  0  |  0  |   1
	// 0  |  0  |  0  |  1  |   1
	// 0  |  0  |  1  |  0  |   0
	// 0  |  0  |  1  |  1  |   1
	// 0  |  1  |  0  |  0  |   1
	// 0  |  1  |  0  |  1  |   0
	// 0  |  1  |  1  |  0  |   0
	// 0  |  1  |  1  |  1  |   1
	// 1  |  0  |  0  |  0  |   1
	// 1  |  0  |  0  |  1  |   1
	// 1  |  0  |  1  |  0  |   0
	// 1  |  0  |  1  |  1  |   0
	// 1  |  1  |  0  |  0  |   1
	// 1  |  1  |  0  |  1  |   1
	// 1  |  1  |  1  |  0  |   1
	// 1  |  1  |  1  |  1  |   1
	
	assign out = (a & b & ~c & (d | (~d))); // Formula derived from the Karnaugh map
	
endmodule
