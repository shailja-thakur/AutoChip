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
      if (ss == 8'b00111001) begin
        ss <= 8'b00000000; // reset seconds
        if (mm == 8'b01101101) begin // adjust BCD representation for minutes to 59 (decimal value)
          mm <= 8'b00000000; // reset minutes
          if (hh == 8'b00011011) begin // adjust BCD representation for hours to 12 (decimal value)
            hh <= 8'b00000001; // reset hours
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

  // Add BCD conversion for hh, mm, and ss
  always @(hh, mm, ss) begin
    // BCD conversion for hh
    if (hh >= 8'b10100000) begin
      hh <= 8'b00010010;
    end else if (hh >= 8'b10010000) begin
      hh <= 8'b00001110;
    end else if (hh >= 8'b10000000) begin
      hh <= 8'b00001100;
    end else if (hh >= 8'b01110000) begin
      hh <= 8'b00001010;
    end else if (hh >= 8'b01100000) begin
      hh <= 8'b00001000;
    end else if (hh >= 8'b01010000) begin
      hh <= 8'b00000110;
    end else if (hh >= 8'b01000000) begin
      hh <= 8'b00000100;
    end else if (hh >= 8'b00110000) begin
      hh <= 8'b00000010;
    end

    // BCD conversion for mm
    if (mm >= 8'b01100000) begin
      mm <= 8'b00001000;
    end else if (mm >= 8'b01010000) begin
      mm <= 8'b00000110;
    end else if (mm >= 8'b01000000) begin
      mm <= 8'b00000100;
    end else if (mm >= 8'b00110000) begin
      mm <= 8'b00000010;
    end

    // BCD conversion for ss
    if (ss >= 8'b01100000) begin
      ss <= 8'b00001000;
    end else if (ss >= 8'b01010000) begin
      ss <= 8'b00000110;
    end else if (ss >= 8'b01000000) begin
      ss <= 8'b00000100;
    end else if (ss >= 8'b00110000) begin
      ss <= 8'b00000010;
    end
  end

endmodule
