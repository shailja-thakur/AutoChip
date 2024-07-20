module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [255:0] in_reg [0:7];
	always @*
	begin
		for (int i = 0; i < 8; i = i + 1)
		begin
			in_reg[i] = in[i * 128 +: 128];
		end
	end

	always @*
	begin
		case (sel)
			8'b00000000: out = in_reg[0];
			8'b00000001: out = in_reg[1];
			8'b00000010: out = in_reg[2];
			8'b00000011: out = in_reg[3];
			8'b00000100: out = in_reg[4];
			8'b00000101: out = in_reg[5];
			8'b00000110: out = in_reg[6];
			8'b00000111: out = in_reg[7];
			default: out = 4'bzzzz;
		endcase
	end

endmodule
