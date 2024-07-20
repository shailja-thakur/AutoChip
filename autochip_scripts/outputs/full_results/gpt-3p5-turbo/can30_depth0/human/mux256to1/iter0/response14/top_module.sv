module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Signal declarations
wire [7:0] select_byte; // Separate the select signal into bytes
wire [255:0] select_bit; // Separate the select signal into individual bits

// Connect select signal to byte and bit signals
assign select_byte = sel;
assign select_bit = {sel, 8'd0};

// Multiplexer
assign out = in[select_byte] & select_bit;

endmodule
