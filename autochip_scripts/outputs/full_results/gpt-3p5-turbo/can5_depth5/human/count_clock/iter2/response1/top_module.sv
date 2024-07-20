module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

  reg [3:0] hh_upper;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
      hh_upper <= 4'b0000;
    end else if (ena) begin
      // Calculate next values
      ss <= ss + 1;
      if (ss == 8'b01101000) begin
        ss <= 8'b00000000;  // Reset seconds to 0
        mm <= mm + 1;      // Increment minutes
        if (mm == 8'b01101000) begin
          mm <= 8'b00000000;  // Reset minutes to 0
          hh_upper <= hh_upper + 1;  // Increment hours (upper digit)
          if (hh_upper == 4'b0001 && hh[3] == 1'b0) begin
            hh[3] <= 1'b1;  // Toggle the 12/24-hour indicator on transition to 1 PM
          end else if (hh_upper == 4'b0010 && hh[3] == 1'b1) begin
            hh[3] <= 1'b0;  // Toggle the 12/24-hour indicator on transition to 1 AM
          end
          if (hh_upper == 4'b0001) begin
            if (hh[2:0] == 3'b101) begin
              hh[2:0] <= 3'b000;  // Reset hours (lower digit) to 1 AM
              pm <= ~pm;
            end else if (hh[2:0] == 3'b110) begin
              hh[2:0] <= 3'b000;  // Reset hours (lower digit) to 1 PM
              pm <= ~pm;
            end else begin
              hh[2:0] <= hh[2:0] + 1;  // Increment hours (lower digit)
            end
          end
        end
      end
    end
  end
endmodule
