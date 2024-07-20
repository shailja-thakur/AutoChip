module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  reg state, next_state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 0;
    else
      state <= next_state;
  end

  always @* begin
    if (state == 0)
      if (j)
        next_state = 1;
      else
        next_state = 0;
    else
      if (k)
        next_state = 0;
      else
        next_state = 1;
  end

  always @(state) begin
    if (state == 1)
      out = 1;
    else
      out = 0;
  end

endmodule
