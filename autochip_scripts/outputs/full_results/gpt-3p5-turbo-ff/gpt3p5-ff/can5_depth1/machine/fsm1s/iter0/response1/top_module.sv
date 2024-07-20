module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg state;

  always @(posedge clk) begin
    if (reset)
      state <= 0;
    else
      state <= (state == 1'b0 && in) ? 1'b1 : (state == 1'b1 && ~in) ? 1'b0 : state;
  end

  assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
