module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
    
  reg [7:0] counter_hh_1;
  reg [7:0] counter_mm_1;
  reg [7:0] counter_ss_1;
  reg [20:0] counter;
  
  always @(posedge clk) begin
    if (reset) begin
      counter_hh_1 <= 8'b00010010; // 12 in BCD
      counter_mm_1 <= 8'b00000000; // 0 in BCD
      counter_ss_1 <= 8'b00000000; // 0 in BCD
      counter <= 21'b0;
      pm <= 1'b0;
    end else begin
      if (ena) begin
        counter <= counter + 1;
        if (counter == 21'b10000000000000000000) begin // 1 sec
          counter <= 21'b0;
          counter_ss_1 <= counter_ss_1 + 1;
          if (counter_ss_1 == 8'b01101000) begin // 59 in BCD
            counter_ss_1 <= 8'b00000000; // 0 in BCD
            counter_mm_1 <= counter_mm_1 + 1;
            if (counter_mm_1 == 8'b01101000) begin // 59 in BCD
              counter_mm_1 <= 8'b00000000; // 0 in BCD
              counter_hh_1 <= counter_hh_1 + 1;
              if (counter_hh_1[7:4] == 8'b00010010 || counter_hh_1[7:4] == 8'b00110010) begin // 12 in BCD (AM) or 12 in BCD (PM)
                counter_hh_1[7:4] <= counter_hh_1[7:4] + 4'b0001; // increment hour
                pm <= ~pm;
              end else if (counter_hh_1[7:4] == 8'b01010001) begin // 09 in BCD
                counter_hh_1[7:4] <= 8'b00010010; // 10 in BCD
              end else if (counter_hh_1[7:4] == 8'b10010010) begin // 19 in BCD
                counter_hh_1[7:4] <= 8'b00000001; // 1 in BCD
              else if (counter_hh_1[7:4] == 8'b10110001) begin // 21 in BCD
                counter_hh_1[7:4] <= 8'b00010010; // 22 in BCD
              end
            end
          end
        end
      end
    end
  end
  
  assign hh = counter_hh_1;
  assign mm = counter_mm_1;
  assign ss = counter_ss_1;
    
endmodule
