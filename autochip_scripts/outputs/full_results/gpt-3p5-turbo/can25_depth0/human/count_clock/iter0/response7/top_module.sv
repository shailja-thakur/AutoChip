module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            {pm, hh, mm, ss} <= 8'b0000_1100; // Reset to "12:00 AM"
        else if (ena)
            if (ss == 8'b0101_1001) begin
                ss <= 8'b0000_0000;
                if (mm == 8'b0101_1001) begin
                    mm <= 8'b0000_0000;
                    if (hh == 8'b0001_0011) // 12 in BCD
                        hh <= 8'b0000_0000; // Reset to "01:00 AM"
                    else if (hh == 8'b0000_1001) // 09 in BCD
                        hh <= {4'b0000, hh[3:0] + 1}; // Increment in BCD
                    else
                        hh <= hh + 1; // Increment in BCD
                end
                else if (mm == 8'b0000_1001) // 09 in BCD
                    mm <= {4'b0000, mm[3:0] + 1}; // Increment in BCD
                else
                    mm <= mm + 1; // Increment in BCD
            end
            else if (ss == 8'b0000_1001) // 09 in BCD
                ss <= {4'b0000, ss[3:0] + 1}; // Increment in BCD
            else
                ss <= ss + 1; // Increment in BCD
    end
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            pm <= 1'b0; // Reset to AM
        else if (ena && ss == 8'b0101_1001) // Carry from SS -> MM
            pm <= ~pm; // Toggle AM/PM
    end
    
endmodule
