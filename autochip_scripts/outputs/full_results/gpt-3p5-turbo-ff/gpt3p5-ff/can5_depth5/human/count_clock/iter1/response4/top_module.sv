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
      pm <= 1'b0;
      hh <= 8'b00000001; // Initialize hours to 12 AM
      mm <= 8'b00000000; // Initialize minutes to 00
      ss <= 8'b00000000; // Initialize seconds to 00
    end else begin
      if (ena) begin
        if (ss == 8'b01111000) begin
          ss <= 8'b00000000; // Reset seconds
          if (mm == 8'b01101000) begin
            mm <= 8'b00000000; // Reset minutes
            if (hh == 8'b00010010) begin
              hh <= 8'b00000001; // Reset hours
              pm <= ~pm; // Toggle AM/PM indicator
            end else begin
              hh <= hh + 1'b1; // Increment hours
            end
          end else begin
            mm <= mm + 1'b1; // Increment minutes
          end
        end else begin
          ss <= ss + 1'b1; // Increment seconds
        end
      end
    end
  end

endmodule
