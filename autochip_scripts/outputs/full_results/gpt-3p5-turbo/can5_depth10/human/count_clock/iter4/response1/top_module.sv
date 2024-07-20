module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [3:0] hh_tens,
    output reg [3:0] hh_ones,
    output reg [3:0] mm_tens,
    output reg [3:0] mm_ones,
    output reg [3:0] ss_tens,
    output reg [3:0] ss_ones);
   
    always @(posedge clk) begin
        if (reset) begin
            hh_tens <= 4'b0001; // 1
            hh_ones <= 4'b0010; // 2
            mm_tens <= 4'b0000; // 0
            mm_ones <= 4'b0000; // 0
            ss_tens <= 4'b0000; // 0
            ss_ones <= 4'b0000; // 0
            pm <= 1'b0; // AM
        end else if (ena) begin
            ss_ones <= ss_ones + 4'b0001;
            if (ss_ones >= 4'b1010) begin // 10 in BCD
                ss_ones <= 4'b0000; // reset ss_ones
                ss_tens <= ss_tens + 4'b0001;
                if (ss_tens >= 4'b0110) begin // 60 in BCD
                    ss_tens <= 4'b0000; // reset ss_tens
                    mm_ones <= mm_ones + 4'b0001;
                    if (mm_ones >= 4'b1010) begin // 10 in BCD
                        mm_ones <= 4'b0000; // reset mm_ones
                        mm_tens <= mm_tens + 4'b0001;
                        if (mm_tens >= 4'b0110) begin // 60 in BCD
                            mm_tens <= 4'b0000; // reset mm_tens
                            hh_ones <= hh_ones + 4'b0001;
                            if (hh_ones == 4'b1001 && hh_tens == 4'b0001) begin // 12 in BCD
                                hh_ones <= 4'b0000; // reset hh_ones
                                hh_tens <= 4'b0001; // reset hh_tens
                                pm <= ~pm; // toggle AM/PM indicator
                            end else if (hh_ones >= 4'b1010) begin // 10 in BCD
                                hh_ones <= 4'b0000; // reset hh_ones
                                hh_tens <= hh_tens + 4'b0001;
                            end
                        end
                    end
                end
            end
        end
    end
   
endmodule
