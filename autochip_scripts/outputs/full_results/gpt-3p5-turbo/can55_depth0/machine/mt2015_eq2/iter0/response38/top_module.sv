module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);
	
	// logic to compare A and B bit by bit
	assign z = (A[0] == B[0]) && (A[1] == B[1]);
	
endmodule
