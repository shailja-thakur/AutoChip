module top_module(
  input clk,
  input d,
  output reg q);

  reg q1;
  always @(posedge clk or negedge clk) begin
    if (clk === 0) begin
      q1 <= d;
    end
  end

  always @(posedge clk or negedge clk) begin
    if (clk === 1) begin
      q <= q1;
    end
  end

endmodule
