module top_module (
	input [254:0] in,
	output  [7:0] out
);
	
	reg[31:0] sum;	
	
	always @(*)
	begin
		sum = in[7:0] + in[15:8] + in[23:16] + in[31:24] + in[39:32] + in[47:40] + in[55:48] + in[63:56] + in[71:64] +
		      in[79:72] + in[87:80] + in[95:88] + in[103:96] + in[111:104] + in[119:112] + in[127:120] + in[135:128] +
		      in[143:136] + in[151:144] + in[159:152] + in[167:160] + in[175:168] + in[183:176] + in[191:184] +
		      in[199:192] + in[207:200] + in[215:208] + in[223:216] + in[231:224] + in[239:232] + in[247:240] + in[254:248];
	end
	
	always @(*)
	begin
		case (sum)
			8'b00000000 : out = 0;
			8'h01 : out = 1;
			8'h02 : out = 2;
			8'h03 : out = 3;
			8'h04 : out = 4;
			8'h05 : out = 5;
			.
			.
			.
			8'hFF : out = 255;
			
		endcase
	end
	
endmodule
