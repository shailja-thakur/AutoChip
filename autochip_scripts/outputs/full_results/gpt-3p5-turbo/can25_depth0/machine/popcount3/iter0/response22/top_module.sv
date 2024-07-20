module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Declare intermediate signals for addition
	wire [2:0] sum;
	
	// Perform the addition
	assign sum = in[2:0] + 3'b000;
	
	// Assign the output bits
	assign out[1] = sum[2];
	assign out[0] = sum[1];
	
endmodule
