module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  // Define internal signals
  reg [3:0] ones_digit;
  reg [3:0] tens_digit;
  reg [3:0] hundreds_digit;
  reg [3:0] thousands_digit;

  // Define enable signals for the upper three digits
  wire ones_ena;
  wire tens_ena;
  wire hundreds_ena;

  // Define the BCD counter
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      ones_digit <= 4'b0000;
      tens_digit <= 4'b0000;
      hundreds_digit <= 4'b0000;
      thousands_digit <= 4'b0000;
      q <= 16'b0000000000000000;
    end else begin
      if (ena[0]) begin
        ones_digit <= ones_digit + 1;
        if (ones_digit == 10) begin
          ones_digit <= 4'b0000;
        end
      end
      
      if (ena[1]) begin
        tens_digit <= tens_digit + 1;
        if (tens_digit == 10) begin
          tens_digit <= 4'b0000;
        end
      end
      
      if (ena[2]) begin
        hundreds_digit <= hundreds_digit + 1;
        if (hundreds_digit == 10) begin
          hundreds_digit <= 4'b0000;
        end
      end
      
      if (ena[3]) begin
        thousands_digit <= thousands_digit + 1;
        if (thousands_digit == 10) begin
          thousands_digit <= 4'b0000;
        end
      end
      
      q <= {thousands_digit, hundreds_digit, tens_digit, ones_digit};
    end
  end
  
  // Assign enable signals
  assign ena = {ones_ena, tens_ena, hundreds_ena};

endmodule
