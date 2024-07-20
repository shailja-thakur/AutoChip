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
       
    reg [3:0] hh_temp, mm_temp, ss_temp;
    
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
            // Increment seconds
            ss_ones <= ss_ones + 1;
            if (ss_ones == 4'b1010) begin
                ss_ones <= 4'b0000; // reset seconds_ones
                ss_tens <= ss_tens + 1;
                if (ss_tens == 4'b1101) begin
                    ss_tens <= 4'b0000; // reset seconds_tens
                    mm_ones <= mm_ones + 1;
                    if (mm_ones == 4'b1010) begin
                        mm_ones <= 4'b0000; // reset minutes_ones
                        mm_tens <= mm_tens + 1;
                        if (mm_tens == 4'b1101) begin
                            mm_tens <= 4'b0000; // reset minutes_tens
                            hh_ones <= hh_ones + 1;
                            if (hh_ones == 4'b1010) begin
                                hh_ones <= 4'b0000; // reset hours_ones
                                hh_tens <= hh_tens + 1;
                                if (hh_tens == 4'b0001) begin
                                    hh_tens <= 4'b0000; // reset hours_tens
                                    pm <= ~pm; // toggle AM/PM indicator
                                end
                            end
                        end
                    end
                end
            end
        end
    end
       
endmodule
