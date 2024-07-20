module top_module(
  input clk,
  input reset,
  output reg [3:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 4'b0;
    else
      q <= q + 4'b1;
  end

endmodule
