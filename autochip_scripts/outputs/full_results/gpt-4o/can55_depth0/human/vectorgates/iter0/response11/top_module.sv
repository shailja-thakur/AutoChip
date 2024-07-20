module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Compute the bitwise OR of a and b
    assign out_or_bitwise = a | b;

    // Compute the logical OR of a and b
    assign out_or_logical = |(a | b);

    // Compute the bitwise NOT of a and b, and place appropriately in out_not
    assign out_not = {~b, ~a};

endmodule
