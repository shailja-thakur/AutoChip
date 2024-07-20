module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    assign out_or_bitwise = a | b;             // Bitwise OR
    assign out_or_logical = |(a | b);          // Logical OR over the entire concatenated vector
    assign out_not = {~b, ~a};                 // Bitwise NOT in reverse order (concatenate ~b and ~a)

endmodule
