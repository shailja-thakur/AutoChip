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
            // Reset to 12:00 AM
            hh <= 8'b0001_0010; // 12
            mm <= 8'b0000_0000; // 00
            ss <= 8'b0000_0000; // 00
            pm <= 1'b0;         // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b0101_1001) begin // 59
                ss <= 8'b0000_0000;
                // Increment minutes
                if (mm == 8'b0101_1001) begin // 59
                    mm <= 8'b0000_0000;
                    // Increment hours
                    if (hh == 8'b0001_0010) begin // 12
                        hh <= 8'b0000_0001; // 01
                        pm <= ~pm;          // Toggle AM/PM
                    end else if (hh == 8'b0000_1001) begin // 09 (Adjust from 0x09 to 0x10)
                        hh <= 8'b0001_0000; // 10
                    end else if (hh <= 8'b0000_1001) begin // 01-09
                        hh <= hh + 8'b0000_0001;
                    end else if (hh <= 8'b0001_0001) begin // 10-11
                        hh <= hh + 8'b0000_0001;
                    end
                end else begin
                    mm <= mm + 8'b0000_0001;
                end
            end else begin
                ss <= ss + 8'b0000_0001;
            end
        end
    end
endmodule
