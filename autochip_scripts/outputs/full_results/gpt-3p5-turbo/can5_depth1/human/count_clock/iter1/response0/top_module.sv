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
            pm <= 1'b0; // Reset to AM
            hh <= 8'b0001; // Reset to 01
            mm <= 8'b0000; // Reset to 00
            ss <= 8'b0000; // Reset to 00
        end else if (ena) begin
            ss <= ss + 1; // Increment seconds
            if (ss == 8'b0101) begin // Check if seconds reach 60
                ss <= 8'b0000; // Reset seconds to 00
                mm <= mm + 1; // Increment minutes
                if (mm == 8'b0110) begin // Check if minutes reach 60
                    mm <= 8'b0000; // Reset minutes to 00
                    hh <= hh + 1; // Increment hours
                    if (hh == 8'b1100 || hh == 8'b1010) begin // Check if hours reach 13 or 24
                        hh <= 8'b0001; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM
                    end
                end
            end
        end
    end
endmodule
