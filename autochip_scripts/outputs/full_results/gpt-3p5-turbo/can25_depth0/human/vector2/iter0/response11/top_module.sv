module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Declare intermediate wire
	wire [31:0] reversed;

	// Reverse the byte order
	assign reversed = {in[7:0], in[15:8], in[23:16], in[31:24]};

	// Assign the reversed value to the output
	assign out = reversed;
endmodule
