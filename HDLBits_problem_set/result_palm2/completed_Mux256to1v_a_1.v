module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [3:0] out_reg;

  always @(sel or in) begin
    case (sel)
      4'b0000: out_reg <= in[3:0];
      4'b0001: out_reg <= in[7:4];
      4'b0010: out_reg <= in[11:8];
      4'b0011: out_reg <= in[15:12];
      4'b0100: out_reg <= in[19:16];
      4'b0101: out_reg <= in[23:20];
      4'b0110: out_reg <= in[27:24];
      4'b0111: out_reg <= in[31:28];
      4'b1000: out_reg <= in[35:32];
      4'b1001: out_reg <= in[39:36];
      4'b1010: out_reg <= in[43:40];
      4'b1011: out_reg <= in[47:44];
      4'b1100: out_reg <= in[51:48];
      4'b1101: out_reg <= in[55:52];
      4'b1110: out_reg <= in[59:56];
      4'b1111: out_reg <= in[63:60];
    endcase
  end

  assign out = out_reg;

endmodule