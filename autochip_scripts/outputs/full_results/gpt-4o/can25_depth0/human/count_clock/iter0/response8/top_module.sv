module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b0001_0010; // 12 in BCD
            mm <= 8'b0000_0000; // 00 in BCD
            ss <= 8'b0000_0000; // 00 in BCD
            pm <= 0;            // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin // 59 in BCD
                ss <= 8'b0000_0000;
                // Increment minutes
                if (mm == 8'b0101_1001) begin // 59 in BCD
                    mm <= 8'b0000_0000;
                    // Increment hours
                    if (hh == 8'b0001_0010) begin // 12 in BCD
                        hh <= 8'b0000_0001; // 01 in BCD
                        pm <= ~pm; // Toggle am/pm
                    end
                    else if (hh == 8'b0000_1001) begin // 09 in BCD
                        hh <= 8'b0001_0000; // 10 in BCD
                    end
                    else if (hh == 8'b0001_0000) begin // 10 in BCD
                        hh <= 8'b0001_0001; // 11 in BCD
                    end
                    else if (hh == 8'b0001_0001) begin // 11 in BCD
                        hh <= 8'b0001_0010; // 12 in BCD
                    end
                    else begin
                        hh <= hh + 1; // Increment other hours normally
                    end
                end
                else begin
                    mm <= mm + 1; // Increment other minutes normally
                end
            end
            else begin
                ss <= ss + 1; // Increment other seconds normally
            end
        end
    end
endmodule
