module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [6:0] bcd_hh;
    reg [6:0] bcd_mm;
    reg [6:0] bcd_ss;

    always @(posedge clk) begin
        if (reset) begin
            pm <= 1'b0; // Reset to AM
            bcd_hh <= 7'b0001001; // Reset to 12
            bcd_mm <= 7'b0000000; // Reset to 00
            bcd_ss <= 7'b0000000; // Reset to 00
        end else if (ena) begin
            bcd_ss <= bcd_ss + 1; // Increment seconds
            if (bcd_ss == 7'b0110000) begin // Check if seconds reach 60
                bcd_ss <= 7'b0000000; // Reset seconds to 00
                bcd_mm <= bcd_mm + 1; // Increment minutes
                if (bcd_mm == 7'b0110110) begin // Check if minutes reach 60
                    bcd_mm <= 7'b0000000; // Reset minutes to 00
                    bcd_hh <= bcd_hh + 1; // Increment hours
                    if (bcd_hh[6:4] == 3'b001 || bcd_hh[6:4] == 3'b010) begin // Check if hours reach 13 or 24
                        bcd_hh <= {3'b000, bcd_hh[3:0]}; // Reset hours to 01
                        pm <= ~pm; // Toggle AM/PM
                    end
                end
            end
        end
    end
    
    assign hh = {bcd_hh[6:4], bcd_hh[3:0]};
    assign mm = {bcd_mm[6:4], bcd_mm[3:0]};
    assign ss = {bcd_ss[6:4], bcd_ss[3:0]};
endmodule
