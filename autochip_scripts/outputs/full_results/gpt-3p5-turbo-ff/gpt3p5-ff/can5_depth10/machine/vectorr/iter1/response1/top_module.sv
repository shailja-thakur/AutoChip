module top_module (
	input [7:0] in,
	output [7:0] out
);

	always @(*)
	begin
		case(in)
			8'b00000000: out = 8'b00000000; // If in = 0, then out = 0
			8'b00000001: out = 8'b10000000; // If in = 1, then out = 128
			8'b00000010: out = 8'b01000000; // If in = 2, then out = 64
			8'b00000011: out = 8'b11000000; // If in = 3, then out = 192
			8'b00000100: out = 8'b00100000; // If in = 4, then out = 32
			8'b00000101: out = 8'b10100000; // If in = 5, then out = 160
			8'b00000110: out = 8'b01100000; // If in = 6, then out = 96
			8'b00000111: out = 8'b11100000; // If in = 7, then out = 224
			8'b00001000: out = 8'b00010000; // If in = 8, then out = 16
			8'b00001001: out = 8'b10010000; // If in = 9, then out = 144
			8'b00001010: out = 8'b01010000; // If in = 10, then out = 80
			8'b00001011: out = 8'b11010000; // If in = 11, then out = 208
			8'b00001100: out = 8'b00110000; // If in = 12, then out = 48
			8'b00001101: out = 8'b10110000; // If in = 13, then out = 176
			8'b00001110: out = 8'b01110000; // If in = 14, then out = 112
			8'b00001111: out = 8'b11110000; // If in = 15, then out = 240
			default: out = 8'b00000000; // For any other value of in, out = 0
		endcase
	end
endmodule
