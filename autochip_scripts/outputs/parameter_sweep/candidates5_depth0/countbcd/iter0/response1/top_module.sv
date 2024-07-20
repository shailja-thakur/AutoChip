module top_module(
  input clk,
  input reset,
  output wire [3:1] ena,
  output reg [15:0] q);
  
  // Define internal signal for one's digit, tens digit, and increment counters
  reg [3:0] ones_digit;
  reg [3:0] tens_digit;
  reg [3:0] inc1;
  reg [3:0] inc2;
  reg [3:0] inc3;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the counters and output
      ones_digit <= 4'b0;
      tens_digit <= 4'b0;
      inc1 <= 4'b0;
      inc2 <= 4'b0;
      inc3 <= 4'b0;
      q <= 16'b0;
    end else begin
      // Increment the counters based on enable signals
      ones_digit <= ones_digit + inc1;
      tens_digit <= tens_digit + inc2;
      
      // Handle overflow for one's and tens digit counters
      if (ones_digit >= 10) begin
        ones_digit <= 4'b0;
        inc2 <= inc2 + 1;
      end
      if (tens_digit >= 10) begin
        tens_digit <= 4'b0;
        inc3 <= inc3 + 1;
      end
      
      // Output the BCD counter
      q = {inc3, tens_digit, inc2, ones_digit};
    end
  end
  
  // Assign enable signals for each digit
  assign ena = {inc3, inc2, inc1};

endmodule
