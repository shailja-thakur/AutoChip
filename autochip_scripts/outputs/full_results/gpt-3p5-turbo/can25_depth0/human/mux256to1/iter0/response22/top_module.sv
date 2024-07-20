module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [255:0] out_reg;

always @(*) begin
	case (sel)
		0: out_reg = in[7:0];
		1: out_reg = in[15:8];
		2: out_reg = in[23:16];
		3: out_reg = in[31:24];
		4: out_reg = in[39:32];
		5: out_reg = in[47:40];
		6: out_reg = in[55:48];
		7: out_reg = in[63:56];
		8: out_reg = in[71:64];
		9: out_reg = in[79:72];
		10: out_reg = in[87:80];
		11: out_reg = in[95:88];
		12: out_reg = in[103:96];
		13: out_reg = in[111:104];
		14: out_reg = in[119:112];
		15: out_reg = in[127:120];
		16: out_reg = in[135:128];
		17: out_reg = in[143:136];
		18: out_reg = in[151:144];
		19: out_reg = in[159:152];
		20: out_reg = in[167:160];
		21: out_reg = in[175:168];
		22: out_reg = in[183:176];
		23: out_reg = in[191:184];
		24: out_reg = in[199:192];
		25: out_reg = in[207:200];
		26: out_reg = in[215:208];
		27: out_reg = in[223:216];
		28: out_reg = in[231:224];
		29: out_reg = in[239:232];
		30: out_reg = in[247:240];
		31: out_reg = in[255:248];
	endcase
end

assign out = out_reg;

endmodule
