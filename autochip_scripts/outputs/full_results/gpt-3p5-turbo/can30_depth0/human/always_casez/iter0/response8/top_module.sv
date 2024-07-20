module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(*)
begin
	case(in)
		8'b00000001: pos = 1;  // first bit is high
		8'b00000010: pos = 2;  // second bit is high
		8'b00000100: pos = 3;  // third bit is high
		8'b00001000: pos = 4;  // fourth bit is high
		8'b00010000: pos = 5;  // fifth bit is high
		8'b00100000: pos = 6;  // sixth bit is high
		8'b01000000: pos = 7;  // seventh bit is high
		8'b10000000: pos = 8;  // eighth bit is high
		default: pos = 0;  // no bits are high
	endcase
end

endmodule
