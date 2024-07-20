module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (!a)
      q <= 0;
    else if (q < 6)
      q <= q + 1;
    else
      q <= 0;
  end

endmodule
