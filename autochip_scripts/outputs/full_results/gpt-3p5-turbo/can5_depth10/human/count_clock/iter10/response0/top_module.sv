module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hh_ones, hh_tens;
  reg [3:0] mm_ones, mm_tens;
  reg [3:0] ss_ones, ss_tens;
  
  always @(posedge clk) begin
    if (reset) begin
      hh_ones <= 4'b0001; // 1
      hh_tens <= 4'b0010; // 2
      mm_ones <= 4'b0000; // 0
      mm_tens <= 4'b0000; // 0
      ss_ones <= 4'b0000; // 0
      ss_tens <= 4'b0000; // 0
      pm <= 1'b0; // AM
    end else if (ena) begin
      if (ss_ones == 4'b1001) begin
        ss_ones <= 4'b0000; // reset seconds ones
        if (ss_tens == 4'b0110) begin // adjust BCD representation for seconds tens to 5 (decimal)
          ss_tens <= 4'b0000; // reset seconds tens
          if (mm_ones == 4'b1001) begin // adjust BCD representation for minutes ones to 9 (decimal)
            mm_ones <= 4'b0000; // reset minutes ones
            if (mm_tens == 4'b0110) begin // adjust BCD representation for minutes tens to 5 (decimal)
              mm_tens <= 4'b0000; // reset minutes tens
              if (hh_ones == 4'b0001 && hh_tens == 4'b0101) begin // adjust BCD representation for hours to 12 (decimal)
                hh_ones <= 4'b0000; // reset hours ones
                hh_tens <= 4'b0001; // reset hours tens
                pm <= ~pm; // toggle AM/PM indicator
              end else if (hh_ones == 4'b0001 && hh_tens == 4'b0010) begin // adjust BCD representation for hours to 10 (decimal)
                hh_ones <= 4'b0000; // reset hours ones
                hh_tens <= 4'b0001; // reset hours tens
                pm <= ~pm; // toggle AM/PM indicator
              end else begin
                hh_tens <= hh_tens + 1;
              end
            end else begin
              mm_tens <= mm_tens + 1;
            end
          end else begin
            mm_ones <= mm_ones + 1;
          end
        end else begin
          ss_tens <= ss_tens + 1;
        end
      end else begin
        ss_ones <= ss_ones + 1;
      end
    end
  end
  
  assign hh = {hh_tens, hh_ones};
  assign mm = {mm_tens, mm_ones};
  assign ss = {ss_tens, ss_ones};

endmodule
