module top_module(
  input clk,
  input d,
  output reg q);

  reg prev_clk;
  always @(posedge clk) begin
    if (prev_clk == 1'b0 && clk == 1'b1) begin
      q <= d;
    end else if (prev_clk == 1'b1 && clk == 1'b0) begin
      q <= q;
    end
    prev_clk <= clk;
  end

endmodule
