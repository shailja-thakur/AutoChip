module top_module (
	input [4:0] x, // corrected input bit-width from [4:1] to [4:0]
	output logic f
);

always_comb begin
	case (x)
		5'b00000: f = 1'b1; // 0x0
		5'b00001: f = 1'b1; // 0x1
		5'b00010: f = 1'b0; // 0x2
		5'b00011: f = 1'b0; // 0x3
		5'b00100: f = 1'b1; // 0x4
		5'b00101: f = 1'b1; // 0x5
		5'b00110: f = 1'b1; // 0x6
		5'b00111: f = 1'b0; // 0x7
		5'b01000: f = 1'b0; // 0x8
		5'b01001: f = 1'b0; // 0x9
		5'b01010: f = 1'b0; // 0xa
		5'b01011: f = 1'b0; // 0xb
		5'b01100: f = 1'b1; // 0xc
		5'b01101: f = 1'b0; // 0xd
		5'b01110: f = 1'b1; // 0xe
		5'b01111: f = 1'b1; // 0xf
		default: f = 1'b0; // default case for undefined states
	endcase
end

endmodule
