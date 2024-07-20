module top_module (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

reg [3:0] hour_tens;
reg [3:0] hour_ones;
reg [3:0] min_tens;
reg [3:0] min_ones;
reg [3:0] sec_tens;
reg [3:0] sec_ones;

always @ (posedge clk or posedge reset) begin
  if (reset) begin
    hh <= 8'b0001_0010; // Set initial value to 12 (BCD)
    mm <= 8'b0000_0000; // Set initial value to 00 (BCD)
    ss <= 8'b0000_0000; // Set initial value to 00 (BCD)
    pm <= 1'b0; // Set initial value to AM
    hour_tens <= 4'b0000;
    hour_ones <= 4'b0000;
    sec_tens <= 4'b0000;
    sec_ones <= 4'b0000;
    min_tens <= 4'b0000;
    min_ones <= 4'b0000;
  end else if (ena) begin
    // Increment seconds
    if (ss == 8'b0101_1001) begin
      ss <= 8'b0000_0000; // Reset seconds to 00 (BCD)
      // Increment minutes
      if (mm == 8'b0101_1001) begin
        mm <= 8'b0000_0000; // Reset minutes to 00 (BCD)
        // Increment hours
        if (hh == 8'b0001_1101) begin
          hh <= 8'b0001_0010; // Reset hours to 12 (BCD)
          pm <= ~pm; // Toggle AM/PM indicator
        end else begin
          if (hour_ones == 4'b1001) begin
            hour_ones <= 4'b0000; // Reset hour ones to 00 (BCD)
            hour_tens <= hour_tens + 1; // Increment hour tens
          end else begin
            hour_ones <= hour_ones + 1; // Increment hour ones
          end
        end
      end else begin
        if (min_ones == 4'b1001) begin
          min_ones <= 4'b0000; // Reset minute ones to 00 (BCD)
          min_tens <= min_tens + 1; // Increment minute tens
        end else begin
          min_ones <= min_ones + 1; // Increment minute ones
        end
      end
    end else begin
      if (sec_ones == 4'b1001) begin
        sec_ones <= 4'b0000; // Reset second ones to 00 (BCD)
        sec_tens <= sec_tens + 1; // Increment second tens
      end else begin
        sec_ones <= sec_ones + 1; // Increment second ones
      end
    end
  end
end

// Output the BCD values to the individual digits
assign hh = {hour_tens, hour_ones};
assign mm = {min_tens, min_ones};
assign ss = {sec_tens, sec_ones};

endmodule
