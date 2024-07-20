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
      pm <= 1'b0;
      hh <= 8'b00010010;  // 12 in BCD format
      mm <= 8'b00000000;  // 00 in BCD format
      ss <= 8'b00000000;  // 00 in BCD format
    end else if (ena) begin
      if (ss == 8'b01011010) begin
        ss <= 8'b00000000;  // 00 in BCD format
        if (mm == 8'b01011010) begin
          mm <= 8'b00000000;  // 00 in BCD format
          if (hh == 8'b00011010) begin
            hh <= 8'b00010010; // 12 in BCD format
            pm <= ~pm;
          end else begin
            hh <= hh + 8'b00000001;  // increment hours by 1
          end
        end else begin
          mm <= mm + 8'b00000001;  // increment minutes by 1
        end
      end else begin
        ss <= ss + 8'b00000001;  // increment seconds by 1
      end
    end
  end

endmodule
