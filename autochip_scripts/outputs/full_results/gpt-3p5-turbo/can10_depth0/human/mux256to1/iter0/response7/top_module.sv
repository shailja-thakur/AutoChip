module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	reg [7:0] in_sel;
	
	always @* begin
		case(sel)
			0: in_sel = in[7:0];
			1: in_sel = in[15:8];
			2: in_sel = in[23:16];
			3: in_sel = in[31:24];
			4: in_sel = in[39:32];
			5: in_sel = in[47:40];
			6: in_sel = in[55:48];
			7: in_sel = in[63:56];
			8: in_sel = in[71:64];
			9: in_sel = in[79:72];
			10: in_sel = in[87:80];
			11: in_sel = in[95:88];
			12: in_sel = in[103:96];
			13: in_sel = in[111:104];
			14: in_sel = in[119:112];
			15: in_sel = in[127:120];
			16: in_sel = in[135:128];
			17: in_sel = in[143:136];
			18: in_sel = in[151:144];
			19: in_sel = in[159:152];
			20: in_sel = in[167:160];
			21: in_sel = in[175:168];
			22: in_sel = in[183:176];
			23: in_sel = in[191:184];
			24: in_sel = in[199:192];
			25: in_sel = in[207:200];
			26: in_sel = in[215:208];
			27: in_sel = in[223:216];
			28: in_sel = in[231:224];
			29: in_sel = in[239:232];
			30: in_sel = in[247:240];
			31: in_sel = in[255:248];
			default: in_sel = 8'h00;
		endcase
	end
	
	assign out = in_sel;
	
endmodule
