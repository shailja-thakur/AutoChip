module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Initialize the clock at 12:00:00 AM
    initial begin
        hh = 8'b00010010; // BCD for 12
        mm = 8'b00000000; // BCD for 00
        ss = 8'b00000000; // BCD for 00
        pm = 0; // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            hh <= 8'b00010010; // BCD for 12
            mm <= 8'b00000000; // BCD for 00
            ss <= 8'b00000000; // BCD for 00
            pm <= 0; // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'b01011001) begin
                ss <= 8'b00000000; // Reset seconds to 00
                // Increment minutes
                if (mm == 8'b01011001) begin
                    mm <= 8'b00000000; // Reset minutes to 00
                    // Increment hours
                    if (hh == 8'b00011001) begin
                        hh <= 8'b00010000; // Roll over from 19 to 10
                    end
                    else if (hh == 8'b00010010) begin
                        hh <= 8'b00000001; // Roll over from 12 to 01
                        pm <= ~pm; // Toggle AM/PM
                    end
                    else begin
                        hh <= hh + 1;
                    end
                end
                else if (mm[3:0] == 4'b1001) begin
                    mm <= {mm[7:4] + 1, 4'b0000}; // Add one to the most significant digit and reset the least significant digit
                end
                else begin
                    mm <= mm + 1;
                end
            end
            else if (ss[3:0] == 4'b1001) begin
                ss <= {ss[7:4] + 1, 4'b0000}; // Add one to the most significant digit and reset the least significant digit
            end
            else begin
                ss <= ss + 1;
            end
        end
    end

endmodule
