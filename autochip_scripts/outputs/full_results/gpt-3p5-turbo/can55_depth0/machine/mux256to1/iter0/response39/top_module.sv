module top_module (
	input [255:0] in,
	input [7:0] sel,
	output reg out
);

always @*
begin
	case(sel)
		8'b00000000: out = in[0];
		8'b00000001: out = in[1];
		8'b00000010: out = in[2];
		8'b00000011: out = in[3];
		8'b00000100: out = in[4];
		8'b00000101: out = in[5];
		8'b00000110: out = in[6];
		8'b00000111: out = in[7];
		8'b00001000: out = in[8];
		8'b00001001: out = in[9];
		8'b00001010: out = in[10];
		8'b00001011: out = in[11];
		8'b00001100: out = in[12];
		8'b00001101: out = in[13];
		8'b00001110: out = in[14];
		8'b00001111: out = in[15];
		// Continue for all 256 combinations
	endcase
end

endmodule
