module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [15:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      next_q <= 0;
    else if (ena[1])
      next_q <= q + 10;
    else if (ena[2])
      next_q <= q + 100;
    else if (ena[3])
      next_q <= q + 1000;
  end

  always @(posedge clk) begin
    if (reset)
      q <= 0;
    else
      q <= next_q;
  end

endmodule
