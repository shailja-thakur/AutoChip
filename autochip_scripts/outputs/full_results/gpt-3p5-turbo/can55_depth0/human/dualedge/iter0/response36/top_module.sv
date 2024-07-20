module top_module(
  input clk,
  input d,
  output reg q);

  reg q_reg;
  reg q_reg_reg;

  always @(posedge clk)
  begin
    q_reg_reg <= q_reg;
    q_reg <= d;
  end

  always @(negedge clk)
  begin
    q <= q_reg_reg;
  end

endmodule
