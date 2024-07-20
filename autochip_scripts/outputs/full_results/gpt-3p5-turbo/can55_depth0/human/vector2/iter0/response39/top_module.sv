module top_module (
	input [31:0] in,
	output [31:0] out
);

// Create a wire to store the reversed byte order
wire [31:0] reversed_byte_order;

// Assign the reversed byte order to the output
assign out = reversed_byte_order;

// The following logic reverses the byte order of the input
// First, swap the position of the MSB and LSB of each byte
assign reversed_byte_order[31:24] = in[7:0];
assign reversed_byte_order[23:16] = in[15:8];
assign reversed_byte_order[15:8] = in[23:16];
assign reversed_byte_order[7:0] = in[31:24];

endmodule
