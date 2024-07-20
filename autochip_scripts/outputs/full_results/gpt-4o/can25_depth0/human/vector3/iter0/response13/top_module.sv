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

    wire [31:0] temp;

    assign temp = {a, b, c, d, e, f, 2'b11}; // Concatenate inputs and add the two 1 bits
    assign {w, x, y, z} = temp; // Split concatenated result into output vectors

endmodule
