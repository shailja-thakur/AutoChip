module top_module(
  input clk,
  input d,
  output reg q);

  reg q;

  initial
  begin
    q = 1'b1;
  end

  always @(posedge clk)
  begin
    q <= d;
  end

endmodule
