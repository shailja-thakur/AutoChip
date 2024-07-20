module top_module(
  input clk,
  input reset,
  output reg [3:0] q
);

  // Counter logic
  always @(posedge clk) begin
    if (reset)
      q <= 4'b0;
    else if (q == 4'b1111)
      q <= 4'b0;
    else
      q <= q + 1;
  end

endmodule
