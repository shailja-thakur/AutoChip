module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
    end else if (ena) begin
      // Increment the clock
      ss <= ss + 1;
      if (ss == 8'b01101000) begin // Check for seconds rollover (59) instead of 8'b01100010
        ss <= 8'b00000000;  // Reset seconds to 0
        mm <= mm + 1;      // Increment minutes
        if (mm == 8'b01101000) begin // Check for minutes rollover (59) instead of 8'b01100010
          mm <= 8'b00000000;  // Reset minutes to 0
          hh <= hh + 1;      // Increment hours
          if (hh == 8'b00011010) begin
            hh <= 8'b00000001;  // Reset hours to 1 AM
            pm <= ~pm;          // Toggle AM/PM indicator
          end else if (hh == 8'b00010100) begin
            hh <= 8'b00000001;  // Reset hours to 1 PM
            pm <= ~pm;          // Toggle AM/PM indicator
          end
        end
      end
    end
  end
endmodule
