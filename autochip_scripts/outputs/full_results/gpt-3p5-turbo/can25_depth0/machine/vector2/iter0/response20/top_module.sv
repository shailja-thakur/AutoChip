module top_module (
	input [31:0] in,
	output [31:0] out
);

	always @(*)
	begin
		out[31:24] = in[7:0];   // Assigning first 8 bits of input to output
		out[23:16] = in[15:8];  // Assigning second 8 bits of input to output
		out[15:8] = in[23:16];  // Assigning third 8 bits of input to output
		out[7:0] = in[31:24];   // Assigning fourth 8 bits of input to output
	end

endmodule
