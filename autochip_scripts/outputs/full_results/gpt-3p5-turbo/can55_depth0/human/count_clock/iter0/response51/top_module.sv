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
            // Reset the clock to "12:00 AM"
            pm <= 0;
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
        end else if (ena) begin
            // Increment the clock once per second
            if (ss == 8'b01011010) begin
                ss <= 8'b00000000; // Reset seconds to 00
                if (mm == 8'b01011010) begin
                    mm <= 8'b00000000; // Reset minutes to 00
                    if (hh == 8'b00010110) begin
                        hh <= 8'b00000000; // Reset hours to 12
                        pm <= ~pm; // Toggle AM/PM indicator
                    end else begin
                        hh <= hh + 1; // Increment hours
                    end
                end else begin
                    mm <= mm + 1; // Increment minutes
                end
            end else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end
endmodule
