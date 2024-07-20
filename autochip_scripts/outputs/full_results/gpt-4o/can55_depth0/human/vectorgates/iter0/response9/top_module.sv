module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Bitwise OR of a and b
    assign out_or_bitwise = a | b;
    
    // Logical OR of a and b (treating as single boolean values)
    assign out_or_logical = |(a | b);
    
    // NOT of b in the upper half of out_not
    assign out_not[5:3] = ~b;
    
    // NOT of a in the lower half of out_not
    assign out_not[2:0] = ~a;

endmodule
