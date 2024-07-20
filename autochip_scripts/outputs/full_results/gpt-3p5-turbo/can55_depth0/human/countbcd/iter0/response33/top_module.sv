module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  reg [3:0] q_ones;    // ones digit
  reg [3:0] q_tens;    // tens digit
  reg [3:0] q_hundreds;    // hundreds digit
  reg [3:0] q_thousands;    // thousands digit

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_ones <= 4'b0;
      q_tens <= 4'b0;
      q_hundreds <= 4'b0;
      q_thousands <= 4'b0;
    end else if (ena[1]) begin
      q_ones <= q_ones + 1;
    end

    if (ena[2]) begin
      if (q_ones == 9) begin
        q_ones <= 4'b0;
        q_tens <= q_tens + 1;
      end
    end

    if (ena[3]) begin
      if (q_tens == 9) begin
        q_tens <= 4'b0;
        q_hundreds <= q_hundreds + 1;
      end
    end

    if (q_hundreds == 9 && q_tens == 9 && ena[3]) begin
      q_hundreds <= 4'b0;
      q_tens <= 4'b0;
      q_thousands <= q_thousands + 1;
    end
  end

  assign q = {q_thousands, q_hundreds, q_tens, q_ones};
  assign ena = {ena[3] && (q_hundreds == 9 && q_tens == 9), ena[3] && (q_tens == 9 && q_hundreds != 9), ena[2] && (q_tens != 9)};
  
endmodule
