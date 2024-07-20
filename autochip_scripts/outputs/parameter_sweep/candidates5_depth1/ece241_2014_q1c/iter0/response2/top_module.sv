module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Internal Signal Declarations
	reg [8:0] sum;
	reg carry_in;
	
	// Combinational Logic for Carry Propagation
	assign {carry_in, sum} = {1'b0, a} + {1'b0, b};
	
	// Assign Output Signals
	assign s = sum[7:0];
	assign overflow = (sum[8] != sum[7]);
endmodule
