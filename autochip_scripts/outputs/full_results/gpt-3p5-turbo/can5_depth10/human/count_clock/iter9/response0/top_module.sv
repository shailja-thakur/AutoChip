module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'b0001_0010; // 12
      mm <= 8'b0000_0000; // 00
      ss <= 8'b0000_0000; // 00
      pm <= 1'b0; // AM
    end else if (ena) begin
      if (ss == 8'b0011_1001) begin
        ss <= 8'b0000_0000; // reset seconds
        if (mm == 8'b0110_1101) begin // adjust BCD representation for minutes to 59 (decimal value)
          mm <= 8'b0000_0000; // reset minutes
          if (hh == 8'b0001_1011) begin // adjust BCD representation for hours to 12 (decimal value)
            hh <= 8'b0000_0001; // reset hours
            pm <= ~pm; // toggle AM/PM indicator
          end else begin
            hh <= hh + 1;
          end
        end else begin
          mm <= mm + 1;
        end
      end else begin
        ss <= ss + 1;
      end
    end
  end

endmodule
