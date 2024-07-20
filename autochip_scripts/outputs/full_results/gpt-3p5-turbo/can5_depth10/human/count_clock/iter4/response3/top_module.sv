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
            hh <= 8'b00000000; // reset hours to 00
            mm <= 8'b00000000; // reset minutes to 00
            ss <= 8'b00000000; // reset seconds to 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            ss <= ss + 1;
            if (ss >= 8'b01101000) begin // check if seconds equal to 59 in BCD
                ss <= 8'b00000000; // reset seconds to 00
                mm <= mm + 1;
                if (mm >= 8'b01111010) begin // check if minutes equal to 59 in BCD
                    mm <= 8'b00000000; // reset minutes to 00
                    hh <= hh + 1;
                    if (hh >= 8'b00010010) begin // check if hours equal to 12 in BCD
                        hh <= 8'b00000001; // reset hours to 01
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end
        end
    end
   
endmodule
