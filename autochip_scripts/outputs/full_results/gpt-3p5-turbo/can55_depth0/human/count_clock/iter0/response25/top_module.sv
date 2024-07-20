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
            pm <= 1'b0;
            hh <= 8'b0001_0010; // set hours to 12 (12 AM)
            mm <= 8'b0000_0000; // set minutes to 0
            ss <= 8'b0000_0000; // set seconds to 0
        end else if (ena) begin
            if (ss == 8'b0101_1001) begin // check if seconds are 59
                ss <= 8'b0000_0000;
                if (mm == 8'b0101_1001) begin // check if minutes are 59
                    mm <= 8'b0000_0000;
                    if (hh == 8'b0001_0010) begin // check if hours are 12
                        hh <= 8'b0000_0001; // set hours to 01
                        pm <= ~pm; // toggle AM/PM indicator
                    end else if (hh == 8'b0000_0001) begin // check if hours are 01
                        hh <= 8'b0000_0000; // set hours to 00
                    end else begin
                        hh <= hh + 1; // increment hours
                    end
                end else begin
                    mm <= mm + 1; // increment minutes
                end
            end else begin
                ss <= ss + 1; // increment seconds
            end
        end
    end

endmodule
