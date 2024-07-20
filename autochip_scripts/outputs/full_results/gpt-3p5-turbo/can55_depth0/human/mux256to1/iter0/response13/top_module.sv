module top_module (
   input [255:0] in,
   input [7:0] sel,
   output out
);

   reg [7:0] temp;
   
   always @(*)
   begin
      case (sel)
         8'b00000000: temp = in[7:0];
         8'b00000001: temp = in[15:8];
         8'b00000010: temp = in[23:16];
         8'b00000011: temp = in[31:24];
         8'b00000100: temp = in[39:32];
         8'b00000101: temp = in[47:40];
         8'b00000110: temp = in[55:48];
         8'b00000111: temp = in[63:56];
         8'b00001000: temp = in[71:64];
         8'b00001001: temp = in[79:72];
         8'b00001010: temp = in[87:80];
         8'b00001011: temp = in[95:88];
         8'b00001100: temp = in[103:96];
         8'b00001101: temp = in[111:104];
         8'b00001110: temp = in[119:112];
         8'b00001111: temp = in[127:120];
         8'b00010000: temp = in[135:128];
         8'b00010001: temp = in[143:136];
         8'b00010010: temp = in[151:144];
         8'b00010011: temp = in[159:152];
         8'b00010100: temp = in[167:160];
         8'b00010101: temp = in[175:168];
         8'b00010110: temp = in[183:176];
         8'b00010111: temp = in[191:184];
         8'b00011000: temp = in[199:192];
         8'b00011001: temp = in[207:200];
         8'b00011010: temp = in[215:208];
         8'b00011011: temp = in[223:216];
         8'b00011100: temp = in[231:224];
         8'b00011101: temp = in[239:232];
         8'b00011110: temp = in[247:240];
         8'b00011111: temp = in[255:248];
         default: temp = 0;
      endcase
      
      out = temp;
   end

endmodule
