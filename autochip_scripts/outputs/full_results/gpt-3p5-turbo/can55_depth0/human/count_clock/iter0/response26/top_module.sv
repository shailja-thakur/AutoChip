module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hour_tens;
  reg [3:0] hour_ones;
  reg [5:0] minutes_tens;
  reg [3:0] minutes_ones;
  reg [5:0] seconds_tens;
  reg [3:0] seconds_ones;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00000010; // set hh to "12"
      mm <= 8'b00000000; // set mm to "00"
      ss <= 8'b00000000; // set ss to "00"
      pm <= 1'b0; // initialize pm to AM
    end 
    else begin
      if (ena) begin
        if (ss == 8'b00111001) begin // if ss is "59"
          ss <= 8'b00000000; // reset ss to "00"
          if (mm == 8'b00111001) begin // if mm is "59"
            mm <= 8'b00000000; // reset mm to "00"
            if (pm && hh == 8'b00001111) // if pm is true and hh is "12"
              hh <= 8'b00000001; // set hh to "01"
            else if (!pm && hh == 8'b00010000) // if pm is false and hh is "01"
              hh <= 8'b00000001; // set hh to "01"
            else
              hh <= hh + 1'b1; // increment hh by 1
          end
          else if (pm && mm == 8'b00001111) // if pm is true and mm is "59"
            mm <= 8'b00000000; // reset mm to "00"
          else if (!pm && mm == 8'b00011110) // if pm is false and mm is "59"
            mm <= 8'b00000000; // reset mm to "00"
          else
            mm <= mm + 1'b1; // increment mm by 1
        end
        else
          ss <= ss + 1'b1; // increment ss by 1
      end
    end
  end
  
  always @(hh) begin
    hour_tens <= hh / 4'b1010; // divide hh by 10 to get the tens digit
    hour_ones <= hh % 4'b1010; // modulo hh by 10 to get the ones digit
  end
  
  always @(mm) begin
    minutes_tens <= mm / 4'b1010; // divide mm by 10 to get the tens digit
    minutes_ones <= mm % 4'b1010; // modulo mm by 10 to get the ones digit
  end
  
  always @(ss) begin
    seconds_tens <= ss / 4'b1010; // divide ss by 10 to get the tens digit
    seconds_ones <= ss % 4'b1010; // modulo ss by 10 to get the ones digit
  end
  
  always @(posedge clk) begin
    if (hh == 8'b00000000) // if hh is "00"
      pm <= 1'b0; // set pm to AM
    else if (hh == 8'b00010010) // if hh is "10"
      pm <= 1'b1; // set pm to PM
  end
  
  // BCD to Seven-Segment Decoder
  
  always @(posedge clk) begin
    case ({hour_tens, hour_ones})
      4'b0000: hh <= 8'b10000001; // set hh to "0"
      4'b0001: hh <= 8'b01111001; // set hh to "1"
      4'b0010: hh <= 8'b01000100; // set hh to "2"
      4'b0011: hh <= 8'b00100100; // set hh to "3"
      4'b0100: hh <= 8'b00011001; // set hh to "4"
      4'b0101: hh <= 8'b00010010; // set hh to "5"
      4'b0110: hh <= 8'b00000010; // set hh to "6"
      4'b0111: hh <= 8'b11111001; // set hh to "7"
      4'b1000: hh <= 8'b00000000; // set hh to "8"
      4'b1001: hh <= 8'b00001000; // set hh to "9"
      4'b1010: hh <= 8'b00011000; // set hh to "Blank"
      default: hh <= 8'b00000100; // set hh to "Error"
    endcase
  end
  
  always @(posedge clk) begin
    case ({minutes_tens, minutes_ones})
      6'b000000: mm <= 8'b10000001; // set mm to "0"
      6'b000001: mm <= 8'b01111001; // set mm to "1"
      6'b000010: mm <= 8'b01000100; // set mm to "2"
      6'b000011: mm <= 8'b00100100; // set mm to "3"
      6'b000100: mm <= 8'b00011001; // set mm to "4"
      6'b000101: mm <= 8'b00010010; // set mm to "5"
      6'b000110: mm <= 8'b00000010; // set mm to "6"
      6'b000111: mm <= 8'b11111001; // set mm to "7"
      6'b001000: mm <= 8'b00000000; // set mm to "8"
      6'b001001: mm <= 8'b00001000; // set mm to "9"
      6'b001010: mm <= 8'b00011000; // set mm to "Blank"
      default: mm <= 8'b00000100; // set mm to "Error"
    endcase
  end
  
  always @(posedge clk) begin
    case ({seconds_tens, seconds_ones})
      6'b000000: ss <= 8'b10000001; // set ss to "0"
      6'b000001: ss <= 8'b01111001; // set ss to "1"
      6'b000010: ss <= 8'b01000100; // set ss to "2"
      6'b000011: ss <= 8'b00100100; // set ss to "3"
      6'b000100: ss <= 8'b00011001; // set ss to "4"
      6'b000101: ss <= 8'b00010010; // set ss to "5"
      6'b000110: ss <= 8'b00000010; // set ss to "6"
      6'b000111: ss <= 8'b11111001; // set ss to "7"
      6'b001000: ss <= 8'b00000000; // set ss to "8"
      6'b001001: ss <= 8'b00001000; // set ss to "9"
      6'b001010: ss <= 8'b00011000; // set ss to "Blank"
      default: ss <= 8'b00000100; // set ss to "Error"
    endcase
  end

endmodule
