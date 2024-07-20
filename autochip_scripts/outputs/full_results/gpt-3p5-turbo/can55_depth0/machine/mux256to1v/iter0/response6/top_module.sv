module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

   // Calculating the starting index of the 4-bit block in the input vector (in)
   reg [11:0] index = sel << 4;

   // Extracting the 4-bit block from the input vector (in) and assigning it to the output vector (out)
   assign out = in[index +: 4];

endmodule
