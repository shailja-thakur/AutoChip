module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

    // Selecting 4-bit chunk based on sel
    assign out = in[sel*4 +: 4];

endmodule
