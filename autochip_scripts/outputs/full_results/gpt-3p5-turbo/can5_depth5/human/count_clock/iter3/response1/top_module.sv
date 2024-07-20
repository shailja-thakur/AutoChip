module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

  // Create internal signals for next values of hh, mm, ss
  reg [3:0] hh_next;
  reg [5:0] mm_next;
  reg [5:0] ss_next;
  
  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
    end else if (ena) begin
      // Calculate next values
      ss_next = ss + 1;
      mm_next = mm;
      hh_next = hh;
      
      if (ss_next == 6'b011010) begin
        ss_next <= 6'b000000;  // Reset seconds to 0
        mm_next <= mm + 1;     // Increment minutes
        if (mm_next == 6'b011010) begin
          mm_next <= 6'b000000;  // Reset minutes to 0
          hh_next <= hh + 1;     // Increment hours
          if (hh_next == 4'b1101) begin
            hh_next <= 4'b0001;  // Reset hours to 1 AM
            pm <= ~pm;           // Toggle AM/PM indicator
          end else if (hh_next == 4'b1010) begin
            hh_next <= 4'b0001;  // Reset hours to 1 PM
            pm <= ~pm;           // Toggle AM/PM indicator
          end
        end
      end
      
      // Assign the next values to the outputs
      ss <= ss_next;
      mm <= mm_next;
      hh <= hh_next;
    end
  end
  
endmodule
