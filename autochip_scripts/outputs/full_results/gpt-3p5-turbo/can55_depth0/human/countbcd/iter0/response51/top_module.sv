module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [3:0] ones, tens, hundreds, thousands;

  always @(posedge clk) begin
    if (reset) begin
      ones <= 0;
      tens <= 0;
      hundreds <= 0;
      thousands <= 0;
    end else begin
      if (ena[1])
        ones <= ones + 1;
      if (ena[2])
        tens <= tens + 1;
      if (ena[3])
        hundreds <= hundreds + 1;
      if (ena[3])
        thousands <= thousands + 1;
    end
  end

  assign q = {thousands, hundreds, tens, ones};

endmodule
