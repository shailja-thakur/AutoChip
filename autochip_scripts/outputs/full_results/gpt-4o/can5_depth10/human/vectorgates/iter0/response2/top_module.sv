module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Bitwise OR operation for each bit in the vectors 'a' and 'b'
    assign out_or_bitwise = a | b;

    // Logical OR operation for the vectors 'a' and 'b'
    assign out_or_logical = |a | |b;

    // Inverse (NOT) operation of the vectors 'a' and 'b'
    // Placing the inverse of b in the upper half and the inverse of a in the lower half of out_not
    assign out_not[5:3] = ~b;
    assign out_not[2:0] = ~a;

endmodule
