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
  
  always @(posedge clk) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'b00000000;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
    end else if (ena) begin
      count_sec <= count_sec + 1'b1;
      if (count_sec == 8'b01101000) begin // If 59 seconds
        count_sec <= 8'b00000000;
        count_min <= count_min + 1'b1;
        if (count_min == 8'b01101000) begin // If 59 minutes
          count_min <= 8'b00000000;
          count_hour <= count_hour + 1'b1;
          if (pm && (count_hour == 8'b00010010)) begin // If 12 hours
            count_hour <= 8'b00000000;
            pm <= ~pm;
          end else if (!pm && (count_hour == 8'b00010010)) begin // If 11 hours
            count_hour <= 8'b00000000;
            pm <= ~pm;
          end else if (count_hour == 8'b00011000) begin // If 23 hours
            count_hour <= 8'b00000000;
          end
        end
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'b00000000;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
    end else if (ena) begin
      if (count_hour == 8'b00011010) begin // If 10 hours
        hh[3:0] <= 4'b0001;
      end else if (count_hour == 8'b00010001) begin // If 01 hours
        hh[7:4] <= 4'b0001;
      end else if (count_hour == 8'b00000000) begin // If 00 hours
        hh <= 8'b00000000;
      end
      
      if (count_min == 8'b00001101) begin // If 59 minutes
        mm[3:0] <= 4'b0001;
      end else if (count_min == 8'b00000000) begin // If 00 minutes
        mm <= 8'b00000000;
      end
      
      if (count_sec == 8'b00001101) begin // If 59 seconds
        ss[3:0] <= 4'b0001;
      end else if (count_sec == 8'b00000000) begin // If 00 seconds
        ss <= 8'b00000000;
      end
    end
  end
endmodule
