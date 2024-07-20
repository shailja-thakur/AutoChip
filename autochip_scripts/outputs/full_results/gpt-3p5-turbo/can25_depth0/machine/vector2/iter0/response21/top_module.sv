module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Use temporary variables to hold the rearranged bits
	wire [31:0] temp1;
	wire [31:0] temp2;
	wire [31:0] temp3;
	
	// Assign the bits to the temporary variables in the desired order
	assign temp1 = {in[7:0], in[15:8], in[23:16], in[31:24]};
	assign temp2 = {temp1[7:0], temp1[15:8], temp1[23:16], temp1[31:24]};
	assign temp3 = {temp2[7:0], temp2[15:8], temp2[23:16], temp2[31:24]};
	
	// Assign the rearranged bits to the output
	assign out = temp3;

endmodule
