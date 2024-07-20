module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

  reg [7:0] count_sec;
  reg [7:0] count_min;
  reg [7:0] count_hour;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010; // 12 in BCD
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0; // AM
      count_sec <= 0;
      count_min <= 0;
      count_hour <= 0;
    end else if (ena) begin
      count_sec <= count_sec + 1;

      if (count_sec == 60) begin
        count_sec <= 0;
        count_min <= count_min + 1;
      end

      if (count_min == 60) begin
        count_min <= 0;
        count_hour <= count_hour + 1;
      end

      if (count_hour == 12) begin
        count_hour <= 0;
        pm <= ~pm;
      end

      if (pm) begin
        if (count_hour == 0) begin
          hh <= 8'b00010010; // 12 in BCD
        end else begin
          hh <= count_hour;
        end
      end else begin
        if (count_hour == 0) begin
          hh <= 8'b00000000; // 00 in BCD
        end else begin
          hh <= count_hour;
        end
      end

      mm <= count_min;
      ss <= count_sec;
    end
  end

endmodule
