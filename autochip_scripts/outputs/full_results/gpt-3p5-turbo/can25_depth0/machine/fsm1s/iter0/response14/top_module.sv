module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg state;

  always @(posedge clk) begin
    if (reset)
      state <= 1'b0;
    else if (state == 1'b0 && in)
      state <= 1'b0;
    else if (state == 1'b0 && !in)
      state <= 1'b1;
    else if (state == 1'b1 && in)
      state <= 1'b1;
    else if (state == 1'b1 && !in)
      state <= 1'b0;
  end

  assign out = state;

endmodule
