module top_module (
	input [31:0] in,
	output [31:0] out
);
	always @* begin
		out[31:24] = in[7:0]; // Assigns the first 8 bits of input to the first 8 bits of output
		out[23:16] = in[15:8]; // Assigns the second 8 bits of input to the second 8 bits of output
		out[15:8] = in[23:16]; // Assigns the third 8 bits of input to the third 8 bits of output
		out[7:0] = in[31:24]; // Assigns the fourth 8 bits of input to the fourth 8 bits of output
	end
endmodule
