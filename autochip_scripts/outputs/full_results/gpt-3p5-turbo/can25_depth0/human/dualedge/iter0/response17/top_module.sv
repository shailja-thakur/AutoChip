module top_module(
  input clk,
  input d,
  output reg q);

  reg q1;
  reg q2;

  always @(posedge clk) begin
    q1 <= d;
  end

  always @(negedge clk) begin
    q2 <= q1;
  end

  always @(posedge clk or negedge clk) begin
    q <= q2;
  end

endmodule
