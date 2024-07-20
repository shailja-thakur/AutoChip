module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(*)
begin
	case(in)
		8'b00000001: pos = 3'b0;
		8'b00000010: pos = 3'b1;
		8'b00000100: pos = 3'b10;
		8'b00001000: pos = 3'b11;
		8'b00010000: pos = 3'b100;
		8'b00100000: pos = 3'b101;
		8'b01000000: pos = 3'b110;
		8'b10000000: pos = 3'b111;
		default: pos = 3'b0;
	endcase
end

endmodule
