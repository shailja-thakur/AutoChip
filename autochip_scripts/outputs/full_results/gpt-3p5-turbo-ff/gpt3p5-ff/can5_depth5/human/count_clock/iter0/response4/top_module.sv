module top_module(
  input wire clk,
  input wire reset,
  input wire ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // Internal counters
  reg [3:0] hour_10, hour_1;
  reg [3:0] min_10, min_1;
  reg [3:0] sec_10, sec_1;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset to 12:00 AM
      hh <= 8'b0001_0010; // 12 in BCD
      mm <= 8'b0000_0000; // 00 in BCD
      ss <= 8'b0000_0000; // 00 in BCD
      pm <= 1'b0;
    end else if (ena) begin
      // Increment counters once per second
      // Increment seconds
      if (ss == 8'b0101_1001) begin // 59 in BCD
        ss <= 8'b0000_0000; // 00 in BCD
        // Increment minutes
        if (mm == 8'b0101_1001) begin // 59 in BCD
          mm <= 8'b0000_0000; // 00 in BCD
          // Increment hours
          if (hh[3:2] == 2'b0001) begin // 12 in BCD
            hh[3:2] <= 2'b0000; // 1 in BCD
          end else if (hh[3:2] == 2'b0000) begin // 09 in BCD
            hh[3:2] <= 2'b0001; // 10 in BCD
          end else if (hh[3:2] == 2'b0001) begin // 10 in BCD
            if (hh[1:0] == 2'b1001) begin // 09 in BCD
              hh[1:0] <= 2'b0000; // 00 in BCD
              pm <= ~pm;
            end else begin
              hh[1:0] <= hh[1:0] + 1; // Increment hours
            end
          end else begin
            hh <= hh + 1; // Increment hours
          end
        end else begin
          mm <= mm + 1; // Increment minutes
        end
      end else begin
        ss <= ss + 1; // Increment seconds
      end
    end
  end

endmodule
