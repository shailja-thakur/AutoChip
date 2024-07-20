module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [6:0] hh,
    output reg [6:0] mm,
    output reg [6:0] ss);
       
    always @(posedge clk) begin
        if (reset) begin
            hh <= 7'b0001001; // 12
            mm <= 7'b0000000; // 00
            ss <= 7'b0000000; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            ss <= ss + 1;
            if (ss >= 7'b0110111) begin // 59
                ss <= 7'b0000000; // reset seconds
                mm <= mm + 1;
                if (mm >= 7'b0111010) begin // 59
                    mm <= 7'b0000000; // reset minutes
                    hh <= hh + 1;
                    if (hh >= 7'b0001101) begin // 12
                        hh <= 7'b0001001; // reset hours
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end
        end
    end
       
endmodule
