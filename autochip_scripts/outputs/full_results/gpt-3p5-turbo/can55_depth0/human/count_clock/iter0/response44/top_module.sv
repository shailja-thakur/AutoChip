module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [3:0] hrs_tens;
  reg [3:0] hrs_ones;
  reg [3:0] mins_tens;
  reg [3:0] mins_ones;
  reg [3:0] secs_tens;
  reg [3:0] secs_ones;
  reg [1:0] cur_am_pm;

  always @(posedge clk) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'b00000000;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      cur_am_pm <= 2'b11;
    end else if (ena) begin
      ss <= ss + 1;
      if (ss == 60) begin
        ss <= 8'b00000000;
        mm <= mm + 1;
        if (mm == 60) begin
          mm <= 8'b00000000;
          hh <= hh + 1;
          if (hh == 12) begin
            hh <= 8'b00000000;
            cur_am_pm <= ~cur_am_pm;
            if (cur_am_pm == 2'b00) begin
              pm <= 1'b0;
            end else if (cur_am_pm == 2'b01) begin
              pm <= 1'b1;
            end
          end
        end
      end
    end
  end

  assign hrs_tens = (hh >= 10) ? (hh-10) : hh;
  assign hrs_ones = (hh >= 10) ? 1'b1 : (hh == 0) ? 1'b0 : (hh >= 5) ? (hh-5) : hh;
  assign mins_tens = (mm >= 50) ? (mm-50) : (mm >= 40) ? (mm-40) : (mm >= 30) ? (mm-30) : (mm >= 20) ? (mm-20) : (mm >= 10) ? (mm-10) : mm;
  assign mins_ones = (mm >= 10) ? 1'b1 : (mm == 0) ? 1'b0 : (mm >= 5) ? (mm-5) : mm;
  assign secs_tens = (ss >= 50) ? (ss-50) : (ss >= 40) ? (ss-40) : (ss >= 30) ? (ss-30) : (ss >= 20) ? (ss-20) : (ss >= 10) ? (ss-10) : ss;
  assign secs_ones = (ss >= 10) ? 1'b1 : (ss == 0) ? 1'b0 : (ss >= 5) ? (ss-5) : ss;

endmodule
