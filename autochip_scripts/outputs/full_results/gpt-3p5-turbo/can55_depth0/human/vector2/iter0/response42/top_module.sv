module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Define internal wires
	wire [7:0] byte0, byte1, byte2, byte3;
	
	assign {byte0, byte1, byte2, byte3} = in;
	assign out = {byte3, byte2, byte1, byte0};
endmodule
