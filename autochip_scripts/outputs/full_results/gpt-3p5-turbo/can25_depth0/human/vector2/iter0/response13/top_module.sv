module top_module (
	input [31:0] in,
	output [31:0] out
);

// Declare internal wires and registers
wire [7:0] byte0;
wire [7:0] byte1;
wire [7:0] byte2;
wire [7:0] byte3;

// Extract individual bytes from input vector
assign byte0 = in[7:0];
assign byte1 = in[15:8];
assign byte2 = in[23:16];
assign byte3 = in[31:24];

// Reassemble bytes in reverse order
assign out = {byte3, byte2, byte1, byte0};

endmodule
