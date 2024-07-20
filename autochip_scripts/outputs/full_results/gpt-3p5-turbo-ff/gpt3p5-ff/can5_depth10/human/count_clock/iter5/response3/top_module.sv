module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
    
  reg [6:0] counter_hh_1;
  reg [6:0] counter_hh_2;
  reg [6:0] counter_mm_1;
  reg [6:0] counter_mm_2;
  reg [6:0] counter_ss_1;
  reg [6:0] counter_ss_2;
  
  always @(posedge clk) begin
    if (reset) begin
      counter_hh_1 <= 7'b0000001; // 1 in BCD
      counter_hh_2 <= 7'b0000010; // 2 in BCD
      counter_mm_1 <= 7'b0000000; // 0 in BCD
      counter_mm_2 <= 7'b0000000; // 0 in BCD
      counter_ss_1 <= 7'b0000000; // 0 in BCD
      counter_ss_2 <= 7'b0000000; // 0 in BCD
      pm <= 1'b0;
    end else begin
      if (ena) begin
        counter_ss_2 <= counter_ss_2 + 1;
        if (counter_ss_2 == 7'b1001001) begin // 9 in BCD
          counter_ss_2 <= 7'b0000000; // 0 in BCD
          counter_ss_1 <= counter_ss_1 + 1;
          if (counter_ss_1 == 7'b1001001) begin // 9 in BCD
            counter_ss_1 <= 7'b0000000; // 0 in BCD
            counter_mm_2 <= counter_mm_2 + 1;
            if (counter_mm_2 == 7'b1001001) begin // 9 in BCD
              counter_mm_2 <= 7'b0000000; // 0 in BCD
              counter_mm_1 <= counter_mm_1 + 1;
              if (counter_mm_1 == 7'b1011010) begin // 59 in BCD
                counter_mm_1 <= 7'b0000000; // 0 in BCD
                counter_hh_2 <= counter_hh_2 + 1;
                if (counter_hh_2 == 7'b0010101) begin // 12 in BCD (AM) or 12 in BCD (PM)
                  counter_hh_2 <= 7'b0000000; // 0 in BCD
                  counter_hh_1 <= counter_hh_1 + 1;
                  pm <= ~pm;
                  if (counter_hh_1 == 7'b1100000) begin // 13 in BCD (PM)
                      counter_hh_1 <= 7'b0000001; // 1 in BCD
                      pm <= ~pm;
                  end else if (counter_hh_1 == 7'b0011001) begin // 20 in BCD
                      counter_hh_1 <= 7'b0000000; // 0 in BCD
                  end else if (counter_hh_1 == 7'b1001111) begin // 29 in BCD
                      counter_hh_1 <= 7'b0000000; // 0 in BCD
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  
  assign hh = {pm, counter_hh_1, counter_hh_2};
  assign mm = {counter_mm_1, counter_mm_2};
  assign ss = {counter_ss_1, counter_ss_2};
    
endmodule
