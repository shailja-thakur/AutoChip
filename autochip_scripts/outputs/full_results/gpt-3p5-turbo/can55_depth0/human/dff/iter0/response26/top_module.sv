module top_module(
  input clk,
  input d,
  output reg q);

  // D flip-flop
  always @(posedge clk) begin
    q <= d;
  end

endmodule
