module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [255:0] in_sel [3:0];
  
  generate
    genvar i;
    for (i = 0; i < 256; i = i + 1) begin : label
      assign in_sel[0][i * 4 +: 4] = in[i * 4 +: 4];
      assign in_sel[1][i * 4 +: 4] = in[i * 4 + 4 +: 4];
      assign in_sel[2][i * 4 +: 4] = in[i * 4 + 8 +: 4];
      assign in_sel[3][i * 4 +: 4] = in[i * 4 + 12 +: 4];
    end
  endgenerate
  
  always @(*) begin
    case (sel)
      0: out = in_sel[0];
      1: out = in_sel[1];
      2: out = in_sel[2];
      3: out = in_sel[3];
      default: out = 4'b0;
    endcase
  end

endmodule
