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
            ss <= 8'h00; // Reset seconds
            mm <= 8'h00; // Reset minutes
            hh <= 8'h12; // Reset hours to 12
            pm <= 1'b0; // Reset to AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00; // Reset seconds to 00 and increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00; // Reset minutes to 00 and increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h9) begin
                        hh <= 8'h10; // 09 becomes 10
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12; // 11 becomes 12
                    end else begin
                        hh <= hh + 1; // Increment to the next hour
                    end
                end else begin
                    mm <= mm + 1; // Increment to the next minute
                end
            end else begin
                ss <= ss + 1; // Increment to the next second
            end
        end
    end
endmodule
