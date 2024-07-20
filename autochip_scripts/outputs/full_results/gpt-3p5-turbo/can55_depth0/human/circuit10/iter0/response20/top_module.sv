module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  always @(posedge clk) begin
    if (a & !b)
      state <= 1;
    else
      state <= 0;

    if (state)
      q <= 1;
    else
      q <= 0;
  end

endmodule
