module top_module (
	input [7:0] in,
	output [7:0] out
);
	// Declare wire to hold the reversed bits
	wire [7:0] reversed_bits;
	
	// Assign reversed bits
	assign reversed_bits = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
	
	// Assign output with reversed bits
	assign out = reversed_bits;
    
endmodule
