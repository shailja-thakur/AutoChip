module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [3:0] out;

  always @(sel or in) begin
    case (sel)
      0: out = in[3:0];
      1: out = in[7:4];
      2: out = in[11:8];
      3: out = in[15:12];
      4: out = in[19:16];
      5: out = in[23:20];
      6: out = in[27:24];
      7: out = in[31:28];
      8: out = in[35:32];
      9: out = in[39:36];
      10: out = in[43:40];
      11: out = in[47:44];
      12: out = in[51:48];
      13: out = in[55:52];
      14: out = in[59:56];
      15: out = in[63:60];
      16: out = in[67:64];
      17: out = in[71:68];
      18: out = in[75:72];
      19: out = in[79:76];
      20: out = in[83:80];
      21: out = in[87:84];
      22: out = in[91:88];
      23: out = in[95:92];
      24: out = in[99:96];
      25: out = in[103:100];
      26: out = in[107:104];
      27: out = in[111:108];
      28: out = in[115:112];
      29: out = in[119:116];
      30: out = in[123:120];
      31: out = in[127:124];
    endcase
  end

endmodule