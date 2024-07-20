module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a) begin
      if (q < 7)
        q <= q + 1;
      else
        q <= 4;
    end else
      q <= 0;
  end

endmodule
