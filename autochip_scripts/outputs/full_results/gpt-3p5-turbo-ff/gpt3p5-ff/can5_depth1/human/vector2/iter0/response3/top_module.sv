module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Declare internal wires and reg
	wire [7:0] in_byte0, in_byte1, in_byte2, in_byte3;
	wire [7:0] out_byte0, out_byte1, out_byte2, out_byte3;
	reg [31:0] temp;

	// Assign input vector to bytes
	assign in_byte0 = in[7:0];
	assign in_byte1 = in[15:8];
	assign in_byte2 = in[23:16];
	assign in_byte3 = in[31:24];

	// Assign reverse order to out bytes
	assign out_byte0 = in_byte3;
	assign out_byte1 = in_byte2;
	assign out_byte2 = in_byte1;
	assign out_byte3 = in_byte0;

	// Concatenate bytes to form output vector
	assign out = {out_byte3, out_byte2, out_byte1, out_byte0};
endmodule
