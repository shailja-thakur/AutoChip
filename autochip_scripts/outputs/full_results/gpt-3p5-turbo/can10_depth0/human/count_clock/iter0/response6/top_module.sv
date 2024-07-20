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
            hh <= 8'b00010010;  // set to 12
            mm <= 8'b00000000;  // set to 00
            ss <= 8'b00000000;  // set to 00
            pm <= 1'b0;         // set to AM
        end else if (ena) begin
            ss <= ss + 1;       // increment seconds
            if (ss >= 8'b01101000) begin
                ss <= 8'b00000000;  // reset seconds to 00
                mm <= mm + 1;       // increment minutes
                if (mm >= 8'b01100000) begin
                    mm <= 8'b00000000;  // reset minutes to 00
                    hh <= hh + 1;       // increment hours
                    if (hh >= 8'b00011010) begin
                        hh <= 8'b00000001;  // reset hours to 01
                        pm <= ~pm;          // toggle AM/PM indicator
                    end
                end
            end
        end
    end
endmodule
