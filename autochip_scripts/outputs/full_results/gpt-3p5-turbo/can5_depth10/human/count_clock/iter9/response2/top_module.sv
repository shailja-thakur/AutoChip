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
      hh <= 8'b00010010; // 12
      mm <= 8'b00000000; // 00
      ss <= 8'b00000000; // 00
      pm <= 1'b0; // AM
    end else if (ena) begin
      if (ss >= 8'b00111001) begin
        ss <= 8'b00000000; // reset seconds
        if (mm >= 8'b01101101) begin // adjust BCD representation for minutes to 59 (decimal value)
          mm <= 8'b00000000; // reset minutes
          if (hh >= 8'b00011011) begin // adjust BCD representation for hours to 12 (decimal value)
            hh <= 8'b00000001; // reset hours
            pm <= ~pm; // toggle AM/PM indicator
          end else begin
            hh <= hh + 8'b00000001;
          end
        end else begin
          mm <= mm + 8'b00000001;
        end
      end else begin
        ss <= ss + 8'b00000001;
      end
    end
  end

endmodule
