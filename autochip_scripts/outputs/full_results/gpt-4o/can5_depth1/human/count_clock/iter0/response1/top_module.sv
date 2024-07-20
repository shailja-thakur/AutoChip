module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Helper function to increment BCD value with carry out
    function [4:0] bcd_increment;
        input [3:0] bcd;
        input cin;
        reg [4:0] sum;
        begin
            sum = bcd + cin;
            if (sum >= 10)
                bcd_increment = sum + 6; // Correcting for BCD addition
            else
                bcd_increment = sum;
        end
    endfunction

    // Reset clock to 12:00 AM and a PM indicator to 0
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00; // 00 in BCD
            mm <= 8'h00; // 00 in BCD
            hh <= 8'h12; // 12 in BCD
            pm <= 0;     // AM
        end else if (ena) begin
            // Increment seconds
            ss[3:0] <= bcd_increment(ss[3:0], 1'b1)[3:0];
            if (ss[3:0] >= 4'b1010 || ss[3:0] == 0) begin
                ss[7:4] <= bcd_increment(ss[7:4], ss[3:0] == 4'b1010);
            end
            
            // Check if seconds overflowed
            if (ss == 8'h60) begin
                ss <= 8'h00;

                // Increment minutes
                mm[3:0] <= bcd_increment(mm[3:0], 1'b1)[3:0];
                if (mm[3:0] >= 4'b1010 || mm[3:0] == 0) begin
                    mm[7:4] <= bcd_increment(mm[7:4], mm[3:0] == 4'b1010);
                end

                // Check if minutes overflowed
                if (mm == 8'h60) begin
                    mm <= 8'h00;

                    // Increment hours
                    hh[3:0] <= bcd_increment(hh[3:0], 1'b1)[3:0];
                    if (hh == 8'h12) begin
                        hh[3:0] <= 4'b0001; // Set to 1
                    end else if (hh[3:0] >= 4'b1010 || hh[3:0] == 0) begin
                        hh[7:4] <= bcd_increment(hh[7:4], hh[3:0] == 4'b1010);
                    end

                    // Check if hours overflowed and toggle AM/PM
                    if (hh == 8'h12 && mm == 8'h00 && ss == 8'h00) begin
                        pm <= ~pm;
                    end

                    // Special case handling for transition from 11 to 12
                    if (hh == 8'h11 && hh[3:0] == 4'b1011) begin
                        hh <= 8'h12;
                    end
                end
            end
        end
    end
endmodule
