module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Create a temporary wire to store the selected input
	wire [1023:0] selected_input;

	// Determine the index of the selected input
	always @* begin
		case(sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			3: selected_input = in[15:12];
			4: selected_input = in[19:16];
			5: selected_input = in[23:20];
			6: selected_input = in[27:24];
			7: selected_input = in[31:28];
			8: selected_input = in[35:32];
			9: selected_input = in[39:36];
			10: selected_input = in[43:40];
			11: selected_input = in[47:44];
			12: selected_input = in[51:48];
			13: selected_input = in[55:52];
			14: selected_input = in[59:56];
			15: selected_input = in[63:60];
			16: selected_input = in[67:64];
			17: selected_input = in[71:68];
			18: selected_input = in[75:72];
			19: selected_input = in[79:76];
			20: selected_input = in[83:80];
			21: selected_input = in[87:84];
			22: selected_input = in[91:88];
			23: selected_input = in[95:92];
			24: selected_input = in[99:96];
			25: selected_input = in[103:100];
			26: selected_input = in[107:104];
			27: selected_input = in[111:108];
			28: selected_input = in[115:112];
			29: selected_input = in[119:116];
			30: selected_input = in[123:120];
			31: selected_input = in[127:124];
			32: selected_input = in[131:128];
			33: selected_input = in[135:132];
			34: selected_input = in[139:136];
			35: selected_input = in[143:140];
			36: selected_input = in[147:144];
			37: selected_input = in[151:148];
			38: selected_input = in[155:152];
			39: selected_input = in[159:156];
			40: selected_input = in[163:160];
			41: selected_input = in[167:164];
			42: selected_input = in[171:168];
			43: selected_input = in[175:172];
			44: selected_input = in[179:176];
			45: selected_input = in[183:180];
			46: selected_input = in[187:184];
			47: selected_input = in[191:188];
			48: selected_input = in[195:192];
			49: selected_input = in[199:196];
			50: selected_input = in[203:200];
			51: selected_input = in[207:204];
			52: selected_input = in[211:208];
			53: selected_input = in[215:212];
			54: selected_input = in[219:216];
			55: selected_input = in[223:220];
			56: selected_input = in[227:224];
			57: selected_input = in[231:228];
			58: selected_input = in[235:232];
			59: selected_input = in[239:236];
			60: selected_input = in[243:240];
			61: selected_input = in[247:244];
			62: selected_input = in[251:248];
			63: selected_input = in[255:252];
			default: selected_input = 0;
		endcase
	end

	// Assign the output to the selected input
	assign out = selected_input[3:0];
endmodule
