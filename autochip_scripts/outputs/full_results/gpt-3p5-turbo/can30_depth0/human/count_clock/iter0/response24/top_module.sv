module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [3:0] hours_tens;
  reg [3:0] hours_ones;
  reg [3:0] minutes_tens;
  reg [3:0] minutes_ones;
  reg [3:0] seconds_tens;
  reg [3:0] seconds_ones;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b0001_0010; // 12 in BCD
      mm <= 8'b0000_0000; // 00 in BCD
      ss <= 8'b0000_0000; // 00 in BCD
      pm <= 1'b0; // AM
    end else if (ena) begin
      if (ss == 8'b0101_1001) begin
        ss <= 8'b0000_0000; // Reset seconds to 00 in BCD
        if (mm == 8'b0101_1001) begin
          mm <= 8'b0000_0000; // Reset minutes to 00 in BCD
          if (hh == 8'b0001_0101) begin
            hh <= 8'b0001_0000; // Reset hours to 01 in BCD
            pm <= ~pm; // Toggle between AM and PM
          end else if (hh == 8'b0000_1001) begin
            hh <= 8'b0001_0000; // Reset hours to 01 in BCD
          end else begin
            hours_ones <= hours_ones + 1; // Increment hours_ones
            if (hours_ones == 8'b0101_1001) begin
              hours_ones <= 8'b0000_0000; // Reset hours_ones to 00 in BCD
              hours_tens <= hours_tens + 1; // Increment hours_tens
            end
          end
        end else begin
          minutes_ones <= minutes_ones + 1; // Increment minutes_ones
          if (minutes_ones == 8'b0101_1001) begin
            minutes_ones <= 8'b0000_0000; // Reset minutes_ones to 00 in BCD
            minutes_tens <= minutes_tens + 1; // Increment minutes_tens
          end
        end
      end else begin
        seconds_ones <= seconds_ones + 1; // Increment seconds_ones
        if (seconds_ones == 8'b0101_1001) begin
          seconds_ones <= 8'b0000_0000; // Reset seconds_ones to 00 in BCD
          seconds_tens <= seconds_tens + 1; // Increment seconds_tens
        end
      end
    end
  end

  always @(hours_tens, hours_ones) begin
    case ({hours_tens, hours_ones})
      8'b0000_0000: hh = 8'b0000_0000; // 00 in BCD
      8'b0000_0001: hh = 8'b0000_0001; // 01 in BCD
      8'b0000_0010: hh = 8'b0000_0010; // 02 in BCD
      8'b0000_0011: hh = 8'b0000_0011; // 03 in BCD
      8'b0000_0100: hh = 8'b0000_0100; // 04 in BCD
      8'b0000_0101: hh = 8'b0000_0101; // 05 in BCD
      8'b0000_0110: hh = 8'b0000_0110; // 06 in BCD
      8'b0000_0111: hh = 8'b0000_0111; // 07 in BCD
      8'b0000_1000: hh = 8'b0000_1000; // 08 in BCD
      8'b0000_1001: hh = 8'b0000_1001; // 09 in BCD
      8'b0001_0000: hh = 8'b0001_0000; // 10 in BCD
      8'b0001_0001: hh = 8'b0001_0001; // 11 in BCD
      8'b0001_0010: hh = 8'b0001_0010; // 12 in BCD
    endcase
  end

  always @(minutes_tens, minutes_ones) begin
    case ({minutes_tens, minutes_ones})
      8'b0000_0000: mm = 8'b0000_0000; // 00 in BCD
      8'b0000_0001: mm = 8'b0000_0001; // 01 in BCD
      8'b0000_0010: mm = 8'b0000_0010; // 02 in BCD
      8'b0000_0011: mm = 8'b0000_0011; // 03 in BCD
      8'b0000_0100: mm = 8'b0000_0100; // 04 in BCD
      8'b0000_0101: mm = 8'b0000_0101; // 05 in BCD
      8'b0000_0110: mm = 8'b0000_0110; // 06 in BCD
      8'b0000_0111: mm = 8'b0000_0111; // 07 in BCD
      8'b0000_1000: mm = 8'b0000_1000; // 08 in BCD
      8'b0000_1001: mm = 8'b0000_1001; // 09 in BCD
      8'b0001_0000: mm = 8'b0001_0000; // 10 in BCD
      8'b0001_0001: mm = 8'b0001_0001; // 11 in BCD
      8'b0001_0010: mm = 8'b0001_0010; // 12 in BCD
      8'b0001_0011: mm = 8'b0001_0011; // 13 in BCD
      8'b0001_0100: mm = 8'b0001_0100; // 14 in BCD
      8'b0001_0101: mm = 8'b0001_0101; // 15 in BCD
      8'b0001_0110: mm = 8'b0001_0110; // 16 in BCD
      8'b0001_0111: mm = 8'b0001_0111; // 17 in BCD
      8'b0001_1000: mm = 8'b0001_1000; // 18 in BCD
      8'b0001_1001: mm = 8'b0001_1001; // 19 in BCD
      8'b0010_0000: mm = 8'b0000_0000; // 20 in BCD
      8'b0010_0001: mm = 8'b0000_0001; // 21 in BCD
      8'b0010_0010: mm = 8'b0000_0010; // 22 in BCD
      8'b0010_0011: mm = 8'b0000_0011; // 23 in BCD
      8'b0010_0100: mm = 8'b0000_0100; // 24 in BCD
      8'b0010_0101: mm = 8'b0000_0101; // 25 in BCD
      8'b0010_0110: mm = 8'b0000_0110; // 26 in BCD
      8'b0010_0111: mm = 8'b0000_0111; // 27 in BCD
      8'b0010_1000: mm = 8'b0000_1000; // 28 in BCD
      8'b0010_1001: mm = 8'b0000_1001; // 29 in BCD
      8'b0011_0000: mm = 8'b0001_0000; // 30 in BCD
      8'b0011_0001: mm = 8'b0001_0001; // 31 in BCD
      8'b0011_0010: mm = 8'b0001_0010; // 32 in BCD
      8'b0011_0011: mm = 8'b0001_0011; // 33 in BCD
      8'b0011_0100: mm = 8'b0001_0100; // 34 in BCD
      8'b0011_0101: mm = 8'b0001_0101; // 35 in BCD
      8'b0011_0110: mm = 8'b0001_0110; // 36 in BCD
      8'b0011_0111: mm = 8'b0001_0111; // 37 in BCD
      8'b0011_1000: mm = 8'b0001_1000; // 38 in BCD
      8'b0011_1001: mm = 8'b0001_1001; // 39 in BCD
      8'b0100_0000: mm = 8'b0010_0000; // 40 in BCD
      8'b0100_0001: mm = 8'b0010_0001; // 41 in BCD
      8'b0100_0010: mm = 8'b0010_0010; // 42 in BCD
      8'b0100_0011: mm = 8'b0010_0011; // 43 in BCD
      8'b0100_0100: mm = 8'b0010_0100; // 44 in BCD
      8'b0100_0101: mm = 8'b0010_0101; // 45 in BCD
      8'b0100_0110: mm = 8'b0010_0110; // 46 in BCD
      8'b0100_0111: mm = 8'b0010_0111; // 47 in BCD
      8'b0100_1000: mm = 8'b0010_1000; // 48 in BCD
      8'b0100_1001: mm = 8'b0010_1001; // 49 in BCD
      8'b0101_0000: mm = 8'b0011_0000; // 50 in BCD
      8'b0101_0001: mm = 8'b0011_0001; // 51 in BCD
      8'b0101_0010: mm = 8'b0011_0010; // 52 in BCD
      8'b0101_0011: mm = 8'b0011_0011; // 53 in BCD
      8'b0101_0100: mm = 8'b0011_0100; // 54 in BCD
      8'b0101_0101: mm = 8'b0011_0101; // 55 in BCD
      8'b0101_0110: mm = 8'b0011_0110; // 56 in BCD
      8'b0101_0111: mm = 8'b0011_0111; // 57 in BCD
      8'b0101_1000: mm = 8'b0011_1000; // 58 in BCD
      8'b0101_1001: mm = 8'b0011_1001; // 59 in BCD
    endcase
  end

  always @(seconds_tens, seconds_ones) begin
    case ({seconds_tens, seconds_ones})
      8'b0000_0000: ss = 8'b0000_0000; // 00 in BCD
      8'b0000_0001: ss = 8'b0000_0001; // 01 in BCD
      8'b0000_0010: ss = 8'b0000_0010; // 02 in BCD
      8'b0000_0011: ss = 8'b0000_0011; // 03 in BCD
      8'b0000_0100: ss = 8'b0000_0100; // 04 in BCD
      8'b0000_0101: ss = 8'b0000_0101; // 05 in BCD
      8'b0000_0110: ss = 8'b0000_0110; // 06 in BCD
      8'b0000_0111: ss = 8'b0000_0111; // 07 in BCD
      8'b0000_1000: ss = 8'b0000_1000; // 08 in BCD
      8'b0000_1001: ss = 8'b0000_1001; // 09 in BCD
      8'b0001_0000: ss = 8'b0001_0000; // 10 in BCD
      8'b0001_0001: ss = 8'b0001_0001; // 11 in BCD
      8'b0001_0010: ss = 8'b0001_0010; // 12 in BCD
      8'b0001_0011: ss = 8'b0001_0011; // 13 in BCD
      8'b0001_0100: ss = 8'b0001_0100; // 14 in BCD
      8'b0001_0101: ss = 8'b0001_0101; // 15 in BCD
      8'b0001_0110: ss = 8'b0001_0110; // 16 in BCD
      8'b0001_0111: ss = 8'b0001_0111; // 17 in BCD
      8'b0001_1000: ss = 8'b0001_1000; // 18 in BCD
      8'b0001_1001: ss = 8'b0001_1001; // 19 in BCD
      8'b0010_0000: ss = 8'b0000_0000; // 20 in BCD
      8'b0010_0001: ss = 8'b0000_0001; // 21 in BCD
      8'b0010_0010: ss = 8'b0000_0010; // 22 in BCD
      8'b0010_0011: ss = 8'b0000_0011; // 23 in BCD
      8'b0010_0100: ss = 8'b0000_0100; // 24 in BCD
      8'b0010_0101: ss = 8'b0000_0101; // 25 in BCD
      8'b0010_0110: ss = 8'b0000_0110; // 26 in BCD
      8'b0010_0111: ss = 8'b0000_0111; // 27 in BCD
      8'b0010_1000: ss = 8'b0000_1000; // 28 in BCD
      8'b0010_1001: ss = 8'b0000_1001; // 29 in BCD
      8'b0011_0000: ss = 8'b0001_0000; // 30 in BCD
      8'b0011_0001: ss = 8'b0001_0001; // 31 in BCD
      8'b0011_0010: ss = 8'b0001_0010; // 32 in BCD
      8'b0011_0011: ss = 8'b0001_0011; // 33 in BCD
      8'b0011_0100: ss = 8'b0001_0100; // 34 in BCD
      8'b0011_0101: ss = 8'b0001_0101; // 35 in BCD
      8'b0011_0110: ss = 8'b0001_0110; // 36 in BCD
      8'b0011_0111: ss = 8'b0001_0111; // 37 in BCD
      8'b0011_1000: ss = 8'b0001_1000; // 38 in BCD
      8'b0011_1001: ss = 8'b0001_1001; // 39 in BCD
      8'b0100_0000: ss = 8'b0010_0000; // 40 in BCD
      8'b0100_0001: ss = 8'b0010_0001; // 41 in BCD
      8'b0100_0010: ss = 8'b0010_0010; // 42 in BCD
      8'b0100_0011: ss = 8'b0010_0011; // 43 in BCD
      8'b0100_0100: ss = 8'b0010_0100; // 44 in BCD
      8'b0100_0101: ss = 8'b0010_0101; // 45 in BCD
      8'b0100_0110: ss = 8'b0010_0110; // 46 in BCD
      8'b0100_0111: ss = 8'b0010_0111; // 47 in BCD
      8'b0100_1000: ss = 8'b0010_1000; // 48 in BCD
      8'b0100_1001: ss = 8'b0010_1001; // 49 in BCD
      8'b0101_0000: ss = 8'b0011_0000; // 50 in BCD
      8'b0101_0001: ss = 8'b0011_0001; // 51 in BCD
      8'b0101_0010: ss = 8'b0011_0010; // 52 in BCD
      8'b0101_0011: ss = 8'b0011_0011; // 53 in BCD
      8'b0101_0100: ss = 8'b0011_0100; // 54 in BCD
      8'b0101_0101: ss = 8'b0011_0101; // 55 in BCD
      8'b0101_0110: ss = 8'b0011_0110; // 56 in BCD
      8'b0101_0111: ss = 8'b0011_0111; // 57 in BCD
      8'b0101_1000: ss = 8'b0011_1000; // 58 in BCD
      8'b0101_1001: ss = 8'b0011_1001; // 59 in BCD
    endcase
  end

endmodule
