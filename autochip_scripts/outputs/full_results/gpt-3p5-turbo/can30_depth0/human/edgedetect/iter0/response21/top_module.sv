module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge);

  reg [7:0] in_reg;

  always @(posedge clk)
  begin
    in_reg <= in;
  end

  always @(posedge clk)
  begin
    pedge <= {in_reg[0] & ~in[0], in_reg[1] & ~in[1], in_reg[2] & ~in[2], in_reg[3] & ~in[3], in_reg[4] & ~in[4], in_reg[5] & ~in[5], in_reg[6] & ~in[6], in_reg[7] & ~in[7]};
  end
  
endmodule
