module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Compute bitwise OR of the inputs
    assign out_or_bitwise = a | b;

    // Compute logical OR of the inputs
    assign out_or_logical = |(a | b);

    // Compute NOT of the inputs and concatenate results
    assign out_not = {~b, ~a};

endmodule
