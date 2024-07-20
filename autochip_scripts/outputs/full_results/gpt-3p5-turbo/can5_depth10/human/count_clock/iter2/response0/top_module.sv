module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [9:0] hh,
    output reg [9:0] mm,
    output reg [9:0] ss);
     
    always @(posedge clk) begin
        if (reset) begin
            hh <= 10'b0000001100;    // 12 in BCD format
            mm <= 10'b0000000000;    // 00 in BCD format
            ss <= 10'b0000000000;    // 00 in BCD format
            pm <= 1'b0;              // AM
        end else if (ena) begin
            ss <= ss + 1;
            if (ss == 10'b0111101000) begin      // 59 in BCD format
                ss <= 10'b0000000000;            // reset seconds
                mm <= mm + 1;
                if (mm == 10'b0111101000) begin  // 59 in BCD format
                    mm <= 10'b0000000000;        // reset minutes
                    hh <= hh + 1;
                    if (hh == 10'b0000001101) begin // 12 in BCD format
                        hh <= 10'b0000001100;     // reset hours
                        pm <= ~pm;                // toggle AM/PM indicator
                    end
                end
            end
        end
    end
     
endmodule
