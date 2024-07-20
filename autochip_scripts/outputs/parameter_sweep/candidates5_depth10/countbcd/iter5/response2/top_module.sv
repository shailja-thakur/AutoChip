module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [15:0] q_next;
  reg [3:0] q_ones, q_tens, q_hundreds, q_thousands;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
    end else begin
      q_ones <= q[3:0];
      q_tens <= q[7:4];
      q_hundreds <= q[11:8];
      q_thousands <= q[15:12];
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q_next <= 0;
    end else begin
      q_ones <= q_ones + (ena[1] && (q_ones == 9));
      q_tens <= q_tens + (ena[2] && (q_tens == 9));
      q_hundreds <= q_hundreds + (ena[3] && (q_hundreds == 9));
      q_thousands <= q_thousands + (ena[3] && (q_thousands == 9));
    end
    q_next = {q_thousands, q_hundreds, q_tens, q_ones};
  end
  
  assign ena = q[7:1];
  assign q = q_next;
  
endmodule
