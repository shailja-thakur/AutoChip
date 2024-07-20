module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create intermediate wires for each 4-bit input
	wire [3:0] in0 = in[sel*4+3:sel*4];
	
	// Use assign statements to assign the output based on the selected input
	assign out = in0;
endmodule
