module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
    
  reg [9:0] counter;
  
  always @(posedge clk) begin
    if (reset) begin
      counter <= 10'b0000000000; // 0 in BCD
      pm <= 1'b0;
    end else begin
      if (ena) begin
        if (counter == 10'b0011001001) begin // 59 in BCD
          counter <= 10'b0000000000; // 0 in BCD
          mm <= mm + 1;
          if (mm == 10'b0110100101) begin // 59 in BCD
            mm <= 10'b0000000000; // 0 in BCD
            hh <= hh + 1;
            if (hh == 10'b0011001001) begin // 12 in BCD (AM) or 12 in BCD (PM)
              hh <= 10'b0000000001; // 1 in BCD
              pm <= ~pm;
            end else if (hh == 10'b0100100110) begin // 20 in BCD
              hh <= 10'b0000000001; // 1 in BCD
            end else if (hh == 10'b0101000001) begin // 21 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101000010) begin // 22 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101000011) begin // 23 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101000100) begin // 24 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101000101) begin // 25 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101000110) begin // 26 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101000111) begin // 27 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101001000) begin // 28 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101001001) begin // 29 in BCD
              hh <= 10'b0000000010; // 2 in BCD
            end else if (hh == 10'b0101001010) begin // 30 in BCD
              hh <= 10'b0000000001; // 1 in BCD
            end
          end
        end else begin
          counter <= counter + 1;
        end
      end
    end
  end
  
  assign hh = {pm, hh[7:4], hh[3:0]};
  assign mm = {mm[7:4], mm[3:0]};
  assign ss = {ss[7:4], ss[3:0]};
    
endmodule
