module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
  
  reg [7:0] temp_hh;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
    end else if (ena) begin
      // Increment the clock
      ss <= ss + 1;
      if (ss == 8'b01100010) begin
        ss <= 8'b00000000;  // Reset seconds to 0
        mm <= mm + 1;      // Increment minutes
        if (mm == 8'b01100010) begin
          mm <= 8'b00000000;  // Reset minutes to 0
          temp_hh <= hh + 1;  // Increment hours in temporary variable
          if (temp_hh == 8'b00011010) begin
            hh <= 8'b00000001;  // Reset hours to 1 AM
            pm <= ~pm;          // Toggle AM/PM indicator
          end else if (temp_hh == 8'b00010010) begin
            hh <= 8'b00000001;  // Reset hours to 1 PM
            pm <= ~pm;          // Toggle AM/PM indicator
          end else begin
            hh <= temp_hh;  // Update the hours value
          end
        end
      end
    end
  end
endmodule
