module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Convert two BCD digits to a single number
    function [7:0] bcd_to_dec;
        input [7:0] bcd;
        begin
            bcd_to_dec = (bcd[7:4] * 10) + bcd[3:0];
        end
    endfunction

    // Convert a single number to two BCD digits
    function [7:0] dec_to_bcd;
        input [7:0] dec;
        begin
            dec_to_bcd[7:4] = dec / 10;
            dec_to_bcd[3:0] = dec % 10;
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            // Reset to "12:00:00 AM"
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        // Toggle AM/PM
                        pm <= ~pm;
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else if (hh[3:0] == 4'h9) begin
                        hh[3:0] <= 4'h0;
                        hh[7:4] <= hh[7:4] + 1;
                    end else begin
                        hh[3:0] <= hh[3:0] + 1;
                    end
                end else if (mm[3:0] == 4'h9) begin
                    mm[3:0] <= 4'h0;
                    mm[7:4] <= mm[7:4] + 1;
                end else begin
                    mm[3:0] <= mm[3:0] + 1;
                end
            end else if (ss[3:0] == 4'h9) begin
                ss[3:0] <= 4'h0;
                ss[7:4] <= ss[7:4] + 1;
            end else begin
                ss[3:0] <= ss[3:0] + 1;
            end
        end
    end
endmodule
