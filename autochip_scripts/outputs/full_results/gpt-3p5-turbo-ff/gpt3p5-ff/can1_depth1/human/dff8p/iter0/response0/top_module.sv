module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q);

  reg [7:0] q2, q3, q4, q5, q6, q7, q8;

  always @(negedge clk) begin
    if (reset)
      q <= 'h34;
    else
      q <= d;
  end

  always @(negedge clk) begin
    q2 <= q;
  end

  always @(negedge clk) begin
    q3 <= q2;
  end

  always @(negedge clk) begin
    q4 <= q3;
  end

  always @(negedge clk) begin
    q5 <= q4;
  end

  always @(negedge clk) begin
    q6 <= q5;
  end

  always @(negedge clk) begin
    q7 <= q6;
  end

  always @(negedge clk) begin
    q8 <= q7;
  end

endmodule
