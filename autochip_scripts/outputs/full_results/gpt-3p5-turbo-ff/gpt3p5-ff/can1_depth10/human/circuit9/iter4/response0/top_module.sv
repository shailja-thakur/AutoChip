module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a)
      q <= q + 1;
    else if (q > 0)
      q <= q - 1;
  end

endmodule
