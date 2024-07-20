module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Create a wire to hold the reversed byte order
	wire [31:0] reversed_byte;

	// Reverse the byte order
	assign reversed_byte = {in[7:0], in[15:8], in[23:16], in[31:24]};

	// Assign the reversed byte order to the output
	assign out = reversed_byte;
	
endmodule
