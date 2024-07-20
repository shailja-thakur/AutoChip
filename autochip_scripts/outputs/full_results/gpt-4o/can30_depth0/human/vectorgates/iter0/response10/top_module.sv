module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    assign out_or_bitwise = a | b;          // Bitwise OR of a and b
    assign out_or_logical = |(a | b);       // Logical OR of a or b (non-zero result produces 1, otherwise 0)
    assign out_not = {~b, ~a};              // Inverse of b in the upper half (bits [5:3]), inverse of a in the lower half (bits [2:0])

endmodule
