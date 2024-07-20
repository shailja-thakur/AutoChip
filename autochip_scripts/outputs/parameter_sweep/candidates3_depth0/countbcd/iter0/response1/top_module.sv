module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output [15:0] q);

  reg [3:0] digit_ones, digit_tens, digit_hundreds, digit_thousands;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      digit_ones <= 4'b0000;
      digit_tens <= 4'b0000;
      digit_hundreds <= 4'b0000;
      digit_thousands <= 4'b0000;
    end else begin
      if (ena[1]) begin
        if (digit_ones == 4'b1001)
          digit_ones <= 4'b0000;
        else
          digit_ones <= digit_ones + 4'b0001;
      end

      if (ena[2]) begin
        if (digit_tens == 4'b1001)
          digit_tens <= 4'b0000;
        else
          digit_tens <= digit_tens + 4'b0001;
      end

      if (ena[3]) begin
        if (digit_hundreds == 4'b1001)
          digit_hundreds <= 4'b0000;
        else
          digit_hundreds <= digit_hundreds + 4'b0001;
      end

      if (digit_thousands == 4'b1001)
        digit_thousands <= 4'b0000;
      else
        digit_thousands <= digit_thousands + 4'b0001;
    end
  end

  assign q = {digit_thousands, digit_hundreds, digit_tens, digit_ones};

endmodule
