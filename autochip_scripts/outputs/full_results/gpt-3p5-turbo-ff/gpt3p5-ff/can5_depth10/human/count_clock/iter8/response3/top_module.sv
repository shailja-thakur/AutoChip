module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
    
  reg [3:0] counter_hh_1;
  reg [3:0] counter_hh_2;
  reg [3:0] counter_mm_1;
  reg [3:0] counter_mm_2;
  reg [3:0] counter_ss_1;
  reg [3:0] counter_ss_2;
  
  always @(posedge clk) begin
    if (reset) begin
      counter_hh_1 <= 4'b0001; // 1 in BCD
      counter_hh_2 <= 4'b0010; // 2 in BCD
      counter_mm_1 <= 4'b0000; // 0 in BCD
      counter_mm_2 <= 4'b0000; // 0 in BCD
      counter_ss_1 <= 4'b0000; // 0 in BCD
      counter_ss_2 <= 4'b0000; // 0 in BCD
      pm <= 1'b0;
    end else begin
      if (ena) begin
        counter_ss_2 <= counter_ss_2 + 1;
        if (counter_ss_2 == 4'b1001) begin // 9 in BCD
          counter_ss_2 <= 4'b0000; // 0 in BCD
          counter_ss_1 <= counter_ss_1 + 1;
          if (counter_ss_1 == 4'b1001) begin // 9 in BCD
            counter_ss_1 <= 4'b0000; // 0 in BCD
            counter_mm_2 <= counter_mm_2 + 1;
            if (counter_mm_2 == 4'b1001) begin // 9 in BCD
              counter_mm_2 <= 4'b0000; // 0 in BCD
              counter_mm_1 <= counter_mm_1 + 1;
              if (counter_mm_1 == 4'b0110) begin // 59 in BCD
                counter_mm_1 <= 4'b0000; // 0 in BCD
                if (counter_hh_1 == 4'b0001 && counter_hh_2 == 4'b0001) begin // 11 (AM) in BCD
                  counter_hh_1 <= 4'b0000; // 0 in BCD
                  counter_hh_2 <= 4'b0000; // 0 in BCD
                end else if (counter_hh_1 == 4'b0000 && counter_hh_2 == 4'b1010) begin // 10 (AM) in BCD
                  counter_hh_1 <= 4'b0001; // 1 in BCD
                  counter_hh_2 <= 4'b0000; // 0 in BCD
                end else if (counter_hh_1 == 4'b0000 && counter_hh_2 == 4'b1011) begin // 11 (PM) in BCD
                  counter_hh_1 <= 4'b0001; // 1 in BCD
                  counter_hh_2 <= 4'b0000; // 0 in BCD
                end else if (counter_hh_1 == 4'b0001 && counter_hh_2 == 4'b0000) begin // 12 (PM) in BCD
                  counter_hh_1 <= 4'b0001; // 1 in BCD
                  counter_hh_2 <= 4'b0001; // 1 in BCD
                  pm <= ~pm;
                end else begin
                  counter_hh_1 <= counter_hh_1 + 1;
                end
              end
            end
          end
        end
      end
    end
  end
  
  assign hh = {counter_hh_1, counter_hh_2};
  assign mm = {counter_mm_1, counter_mm_2};
  assign ss = {counter_ss_1, counter_ss_2};
    
endmodule
