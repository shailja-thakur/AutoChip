module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
    
  reg [7:0] counter_hh;
  reg [7:0] counter_mm;
  reg [7:0] counter_ss;
  
  always @(posedge clk) begin
    if (reset) begin
      counter_hh <= 8'b00010010; // 12 in BCD
      counter_mm <= 8'b00000000; // 0 in BCD
      counter_ss <= 8'b00000000; // 0 in BCD
      pm <= 1'b0;
    end else begin
      if (ena) begin
        counter_ss <= counter_ss + 1;
        if (counter_ss == 8'b01101000) begin // 59 in BCD
          counter_ss <= 8'b00000000; // 0 in BCD
          counter_mm <= counter_mm + 1;
          if (counter_mm == 8'b01111000) begin // 59 in BCD
            counter_mm <= 8'b00000000; // 0 in BCD
            counter_hh <= counter_hh + 1;
            if (counter_hh == 8'b00010010 || counter_hh == 8'b00110010) begin // 12 in BCD (AM) or 12 in BCD (PM)
              counter_hh <= 8'b00000001; // 1 in BCD
              pm <= ~pm;
            else if (counter_hh == 8'b00001001) begin // 9 in BCD
              counter_hh <= 8'b00010000; // 10 in BCD
            end else if (counter_hh == 8'b00011110) begin // 30 in BCD
              counter_hh <= 8'b00000001; // 1 in BCD
            end else if (counter_hh == 8'b00011111) begin // 31 in BCD
              counter_hh <= 8'b00000001; // 1 in BCD
            end else if (counter_hh == 8'b00100000) begin // 32 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00100001) begin // 33 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00100010) begin // 34 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00100011) begin // 35 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            else if (counter_hh == 8'b00101111) begin // 47 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00110110) begin // 54 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00110111) begin // 55 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00111000) begin // 56 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00111001) begin // 57 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00111010) begin // 58 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b00111011) begin // 59 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000000) begin // 60 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000001) begin // 61 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000010) begin // 62 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000011) begin // 63 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000100) begin // 64 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000101) begin // 65 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000110) begin // 66 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01000111) begin // 67 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01001000) begin // 68 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end else if (counter_hh == 8'b01001001) begin // 69 in BCD
              counter_hh <= 8'b00000010; // 2 in BCD
            end
          end
        end
      end
    end
  end
  
  assign hh = {pm, counter_hh};
  assign mm = {counter_mm};
  assign ss = {counter_ss};
    
endmodule
