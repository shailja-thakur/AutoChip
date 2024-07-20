module top_module(
  input clk,
  input reset,
  output reg [3:0] q);

  // Internal wire for counting
  wire [3:0] next_q;

  // Flip flop for the counter
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 0;
    else
      q <= next_q;
  end

  // Logic for counting
  always @(posedge clk) begin
    if (reset)
      next_q <= 0;
    else if (q == 15)
      next_q <= 0;
    else
      next_q <= q + 1;
  end

endmodule
