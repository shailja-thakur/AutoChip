module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);
	
	// Concatenate input vectors
	reg [29:0] input_concat;
	always @(a, b, c, d, e, f)
		input_concat = {a, b, c, d, e, f};
	
	// Add two 1 bits in the LSB positions of the input_concat
	reg [31:0] output_concat;
	always @(input_concat)
		output_concat = {input_concat, 2'b11};

	// Split output_concat into output vectors
	assign {w, x, y, z} = output_concat;

endmodule
