module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Compute the bitwise OR of the two 3-bit vectors
    assign out_or_bitwise = a | b;
    
    // Compute the logical OR of the two 3-bit vectors
    assign out_or_logical = |(a | b);
    
    // Compute the inverse (NOT) of both vectors
    // Place the inverse of b in the upper half of out_not (bits [5:3])
    assign out_not[5:3] = ~b;
    // Place the inverse of a in the lower half of out_not (bits [2:0])
    assign out_not[2:0] = ~a;

endmodule
