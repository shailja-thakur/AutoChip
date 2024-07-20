module top_module (
	input [7:0] in,
	output [7:0] out
);
	
	// Declare wire variables for intermediate calculations
	wire [7:0] reversed;
	
	// Reverse the bit ordering
	assign reversed[7] = in[0];
	assign reversed[6] = in[1];
	assign reversed[5] = in[2];
	assign reversed[4] = in[3];
	assign reversed[3] = in[4];
	assign reversed[2] = in[5];
	assign reversed[1] = in[6];
	assign reversed[0] = in[7];
	
	// Output the reversed vector
	assign out = reversed;

endmodule
