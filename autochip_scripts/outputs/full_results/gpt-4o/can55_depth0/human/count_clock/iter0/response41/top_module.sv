module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // This block handles the clock reset or increment
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 1'b0;        // AM
        end
        else if (ena) begin
            // Increment the seconds
            if (ss[3:0] == 4'b1001) begin // if the lower BCD digit is 9
                if (ss[7:4] == 4'b0101) begin // if the upper BCD digit is 5
                    ss <= 8'b00000000; // reset seconds to 00
                    // Increment the minutes
                    if (mm[3:0] == 4'b1001) begin // if the lower BCD digit is 9
                        if (mm[7:4] == 4'b0101) begin // if the upper BCD digit is 5
                            mm <= 8'b00000000; // reset minutes to 00
                            // Increment the hours
                            if (hh[3:0] == 4'b1001) begin // if the lower BCD digit is 9
                                if (hh[7:4] == 4'b0001) begin // if the upper BCD digit is 1
                                    hh <= 8'b00010000; // set hours to 10
                                end else begin
                                    hh <= hh + 8'b00000001; // increment lower BCD digit of hours
                                end
                            end else if ((hh == 8'b00010010) && (pm == 1'b1)) begin // if hours is 12 and PM
                                hh <= 8'b00000001; // set hours to 1
                                pm <= 1'b0; // toggle AM/PM
                            end else begin
                                hh <= hh + 8'b00000001; // increment hours
                            end
                        end else begin
                            mm <= mm + 8'b00010000; // increment upper BCD digit of minutes
                        end
                    end else begin
                        mm <= mm + 8'b00000001; // increment lower BCD digit of minutes
                    end
                end else begin
                    ss <= ss + 8'b00010000; // increment upper BCD digit of seconds
                end
            end else begin
                ss <= ss + 8'b00000001; // increment lower BCD digit of seconds
            end
        end
    end

endmodule
