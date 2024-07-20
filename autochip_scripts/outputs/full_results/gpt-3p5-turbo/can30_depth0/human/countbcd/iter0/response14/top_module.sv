module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
	
  reg [3:0] ones_digit;
  reg [3:0] tens_digit;
  reg [3:0] hundreds_digit;
  reg [3:0] thousands_digit;

  always @(posedge clk, posedge reset) begin
    if (reset)
      q <= 0;
    else if (ena[1])
      ones_digit <= ones_digit + 1;
    else if (ena[2])
      tens_digit <= tens_digit + 1;
    else if (ena[3])
      hundreds_digit <= hundreds_digit + 1;
    else
      thousands_digit <= thousands_digit + 1;
  end

  always @(posedge clk) begin
    q[3:0] = ones_digit;
    q[7:4] = tens_digit;
    q[11:8] = hundreds_digit;
    q[15:12] = thousands_digit;
  end
endmodule
