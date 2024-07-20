module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    assign out_or_bitwise = a | b; // Bitwise OR
    assign out_or_logical = |(a | b); // Logical OR, combining the bits using bitwise OR, then reducing to single bit with another OR
    assign out_not = {~b, ~a}; // {inverse of b, inverse of a}

endmodule
