module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if (reset)
            {hh, mm, ss} <= 8'b00001100; // reset to "12:00 AM"
        else if (ena)
            if (ss == 8'b00111001) begin // if ss = 59
                ss <= 8'b00000000; // reset seconds to 00
                if (mm == 8'b00111000) begin // if mm = 59
                    mm <= 8'b00000000; // reset minutes to 00
                    if (hh == 8'b00011111) // if hh = 12
                        hh <= 8'b00000001; // reset hours to 01
                    else if (hh == 8'b00001111) // if hh = 11
                        hh <= 8'b00010000; // set hours to 12
                    else if (hh[3:0] == 4'b0001) // if hh is 01-09
                        hh <= {hh[7:4], hh[3:0] + 1}; // increment hours by 1
                    else // if hh is 10
                        hh <= 8'b00010001; // set hours to 11
                end
                else if (mm[3:0] == 4'b0009) // if mm is 09
                    mm <= {mm[7:4], mm[3:0] + 1}; // increment minutes by 1
                else // if mm is 00-08
                    mm <= {mm[7:4], mm[3:0] + 1}; // increment minutes by 1
            end
            else if (ss[3:0] == 4'b1001) // if ss is 09
                ss <= {ss[7:4], ss[3:0] + 1}; // increment seconds by 1
            else // if ss is 00-08
                ss <= {ss[7:4], ss[3:0] + 1}; // increment seconds by 1
            
            if (hh[5] == 1'b1)
                pm <= 1'b1; // set pm to 1 if hour is PM
            else
                pm <= 1'b0; // set pm to 0 if hour is AM
    end

endmodule
