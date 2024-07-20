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
            // Reset to 12:00:00 AM
            hh <= 8'h12; // 12 in BCD
            mm <= 8'h00; // 00 in BCD
            ss <= 8'h00; // 00 in BCD
            pm <= 1'b0; // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'h9) begin
                ss[7:4] <= ss[7:4] + 1;
                ss[3:0] <= 4'h0;
            end
            else begin
                ss[3:0] <= ss[3:0] + 1;
            end
            
            // Check if seconds reset to 00
            if (ss == 8'h60) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm[3:0] == 4'h9) begin
                    mm[7:4] <= mm[7:4] + 1;
                    mm[3:0] <= 4'h0;
                end
                else begin
                    mm[3:0] <= mm[3:0] + 1;
                end
                
                // Check if minutes reset to 00
                if (mm == 8'h60) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh[3:0] == 4'h9) begin
                        hh[7:4] <= hh[7:4] + 1;
                        hh[3:0] <= 4'h0;
                    end
                    else if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end
                    else begin
                        hh[3:0] <= hh[3:0] + 1;
                    end
                end
            end
        end
    end
endmodule
