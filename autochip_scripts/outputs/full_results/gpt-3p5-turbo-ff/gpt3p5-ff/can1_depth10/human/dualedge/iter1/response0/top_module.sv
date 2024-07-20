module top_module(
  input clk,
  input d,
  output reg q);

  reg prev_clk;
  always @(posedge clk) begin
    if (clk != prev_clk) begin
      q <= d;
    end else if (clk) begin
      q <= q;
    end
    prev_clk <= clk;
  end

endmodule
