module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
  wire [255:0] sel_ext;
  wire [255:0] sel_mux;
  
  assign sel_ext = {8{sel}};
  
  always @ (sel_ext or in) begin
    case (sel_ext)
      8'b00000000: sel_mux = in[7:0];
      8'b00000001: sel_mux = in[15:8];
      8'b00000010: sel_mux = in[23:16];
      8'b00000011: sel_mux = in[31:24];
      8'b00000100: sel_mux = in[39:32];
      8'b00000101: sel_mux = in[47:40];
      8'b00000110: sel_mux = in[55:48];
      8'b00000111: sel_mux = in[63:56];
      8'b00001000: sel_mux = in[71:64];
      8'b00001001: sel_mux = in[79:72];
      8'b00001010: sel_mux = in[87:80];
      8'b00001011: sel_mux = in[95:88];
      8'b00001100: sel_mux = in[103:96];
      8'b00001101: sel_mux = in[111:104];
      8'b00001110: sel_mux = in[119:112];
      8'b00001111: sel_mux = in[127:120];
      8'b00010000: sel_mux = in[135:128];
      8'b00010001: sel_mux = in[143:136];
      8'b00010010: sel_mux = in[151:144];
      8'b00010011: sel_mux = in[159:152];
      8'b00010100: sel_mux = in[167:160];
      8'b00010101: sel_mux = in[175:168];
      8'b00010110: sel_mux = in[183:176];
      8'b00010111: sel_mux = in[191:184];
      8'b00011000: sel_mux = in[199:192];
      8'b00011001: sel_mux = in[207:200];
      8'b00011010: sel_mux = in[215:208];
      8'b00011011: sel_mux = in[223:216];
      8'b00011100: sel_mux = in[231:224];
      8'b00011101: sel_mux = in[239:232];
      8'b00011110: sel_mux = in[247:240];
      8'b00011111: sel_mux = in[255:248];
      
      default: sel_mux = in[7:0];
    endcase
  end
  
  assign out = sel_mux;
  
endmodule
