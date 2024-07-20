module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);
  
  always @ (sel) begin
    case(sel)
      4'd0: out <= in[3:0];
      4'd1: out <= in[7:4];
      4'd2: out <= in[11:8];
      4'd3: out <= in[15:12];
      4'd4: out <= in[19:16];
      4'd5: out <= in[23:20];
      4'd6: out <= in[27:24];
      4'd7: out <= in[31:28];
      4'd8: out <= in[35:32];
      4'd9: out <= in[39:36];
      4'd10: out <= in[43:40];
      4'd11: out <= in[47:44];
      4'd12: out <= in[51:48];
      4'd13: out <= in[55:52];
      4'd14: out <= in[59:56];
      4'd15: out <= in[63:60];
      4'd16: out <= in[67:64];
      4'd17: out <= in[71:68];
      4'd18: out <= in[75:72];
      4'd19: out <= in[79:76];
      4'd20: out <= in[83:80];
      4'd21: out <= in[87:84];
      4'd22: out <= in[91:88];
      4'd23: out <= in[95:92];
      4'd24: out <= in[99:96];
      4'd25: out <= in[103:100];
      4'd26: out <= in[107:104];
      4'd27: out <= in[111:108];
      4'd28: out <= in[115:112];
      4'd29: out <= in[119:116];
      4'd30: out <= in[123:120];
      4'd31: out <= in[127:124];
      4'd32: out <= in[131:128];
      4'd33: out <= in[135:132];
      4'd34: out <= in[139:136];
      4'd35: out <= in[143:140];
      4'd36: out <= in[147:144];
      4'd37: out <= in[151:148];
      4'd38: out <= in[155:152];
      4'd39: out <= in[159:156];
      4'd40: out <= in[163:160];
      4'd41: out <= in[167:164];
      4'd42: out <= in[171:168];
      4'd43: out <= in[175:172];
      4'd44: out <= in[179:176];
      4'd45: out <= in[183:180];
      4'd46: out <= in[187:184];
      4'd47: out <= in[191:188];
      4'd48: out <= in[195:192];
      4'd49: out <= in[199:196];
      4'd50: out <= in[203:200];
      4'd51: out <= in[207:204];
      4'd52: out <= in[211:208];
      4'd53: out <= in[215:212];
      4'd54: out <= in[219:216];
      4'd55: out <= in[223:220];
      4'd56: out <= in[227:224];
      4'd57: out <= in[231:228];
      4'd58: out <= in[235:232];
      4'd59: out <= in[239:236];
      4'd60: out <= in[243:240];
      4'd61: out <= in[247:244];
      4'd62: out <= in[251:248];
      4'd63: out <= in[255:252];
      default: out <= 4'bz;
    endcase
  end
endmodule
