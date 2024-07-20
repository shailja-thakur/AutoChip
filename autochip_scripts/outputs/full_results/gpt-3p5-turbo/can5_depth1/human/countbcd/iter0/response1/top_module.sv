module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

  reg [3:0] ones_digit;
  reg [3:0] tens_digit;
  reg [3:0] hundreds_digit;
  reg [3:0] thousands_digit;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 0;
    else begin
      if (ena[0])
        ones_digit <= ones_digit + 1;
      if (ena[1])
        tens_digit <= tens_digit + 1;
      if (ena[2])
        hundreds_digit <= hundreds_digit + 1;
      if (ena[3])
        thousands_digit <= thousands_digit + 1;
        
      q[3:0] = ones_digit;
      q[7:4] = tens_digit;
      q[11:8] = hundreds_digit;
      q[15:12] = thousands_digit;
    end
  end
  
endmodule
