module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh <= 8'b0001_0010;  // 12 in BCD
            mm <= 8'b0000_0000;  // 00 in BCD
            ss <= 8'b0000_0000;  // 00 in BCD
            pm <= 1'b0;
        end else if (ena) begin
            ss <= ss + 1;
            if (ss == 8'b0110_0000) begin  // 60 in BCD
                ss <= 8'b0000_0000;       // Reset the seconds to 0
                mm <= mm + 1;
                if (mm == 8'b0110_0000) begin  // 60 in BCD
                    mm <= 8'b0000_0000;       // Reset the minutes to 0
                    hh <= hh + 1;
                    if (hh == 8'b0001_0011) begin  // 13 in BCD
                        hh <= 8'b0000_0001;       // Reset the hours to 1
                        pm <= ~pm;                // Toggle AM/PM indicator
                    end else if (hh == 8'b0001_0100) begin  // 14 in BCD
                        hh <= 8'b0000_0000;               // Reset the hours to 0
                        pm <= ~pm;                        // Toggle AM/PM indicator
                    end
                end
            end
        end
    end

endmodule
