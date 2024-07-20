module top_module (
	input [7:0] in,
	output reg [2:0] pos
);
	always @(*) begin
		casez(in)
			8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000, 8'b00010000, 8'b00100000, 8'b01000000, 8'b10000000: pos = 3'b0; // None of the bits are high
			8'b00000011: pos = 3'b0; // Bit 0 and bit 1 are high
			8'b00000111: pos = 3'b1; // Bit 0, 1 and 2 are high
			8'b00001111: pos = 3'b2; // Bit 0, 1, 2 and 3 are high
			8'b00011111: pos = 3'b3; // Bit 0, 1, 2, 3, and 4 are high
			8'b00111111: pos = 3'b4; // Bit 0, 1, 2, 3, 4 and 5 are high
			8'b01111111: pos = 3'b5; // Bit 0, 1, 2, 3, 4, 5 and 6 are high
			8'b11111111: pos = 3'b6; // All bits are high
			default: pos = 3'b0; // None of the bits are high
		endcase
	end
endmodule
