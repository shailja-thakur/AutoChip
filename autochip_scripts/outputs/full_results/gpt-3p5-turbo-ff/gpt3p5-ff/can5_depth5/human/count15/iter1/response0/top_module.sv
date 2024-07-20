module top_module(
  input clk,
  input reset,
  output reg [3:0] q);

  reg [3:0] q_next;

  always @(posedge clk) begin
    if (reset)
      q <= 0;
    else
      q <= q_next;
  end

  always @(posedge clk) begin
    if (reset)
      q_next <= 0;
    else begin
      if (q == 15)
        q_next <= 0;
      else
        q_next <= q + 1;
    end
  end

endmodule
