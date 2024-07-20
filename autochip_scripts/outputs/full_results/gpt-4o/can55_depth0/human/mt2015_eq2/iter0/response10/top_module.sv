module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);
    
    // Assign z to 1 if A is equal to B, otherwise 0
    assign z = (A == B) ? 1'b1 : 1'b0;

endmodule
