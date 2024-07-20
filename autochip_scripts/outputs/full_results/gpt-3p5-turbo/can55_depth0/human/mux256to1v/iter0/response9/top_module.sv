module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

  reg [3:0] out_reg;

  always @(*) begin
    case (sel)
      0: out_reg = in[3:0];
      1: out_reg = in[7:4];
      2: out_reg = in[11:8];
      3: out_reg = in[15:12];
      4: out_reg = in[19:16];
      5: out_reg = in[23:20];
      6: out_reg = in[27:24];
      7: out_reg = in[31:28];
      8: out_reg = in[35:32];
      9: out_reg = in[39:36];
      10: out_reg = in[43:40];
      11: out_reg = in[47:44];
      12: out_reg = in[51:48];
      13: out_reg = in[55:52];
      14: out_reg = in[59:56];
      15: out_reg = in[63:60];
      16: out_reg = in[67:64];
      17: out_reg = in[71:68];
      18: out_reg = in[75:72];
      19: out_reg = in[79:76];
      20: out_reg = in[83:80];
      21: out_reg = in[87:84];
      22: out_reg = in[91:88];
      23: out_reg = in[95:92];
      24: out_reg = in[99:96];
      25: out_reg = in[103:100];
      // ... continue with the rest of the cases
    endcase
  end

  assign out = out_reg;

endmodule
