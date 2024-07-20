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
            pm <= 1'b0;
            hh <= 8'b00001100; // reset to 12
            mm <= 8'b00000000; // reset to 00
            ss <= 8'b00000000; // reset to 00
        end else if (ena) begin
            if (ss == 8'b01011001) begin // if seconds is 59
                ss <= 8'b00000000; // reset seconds to 00
                mm <= mm + 1; // increment minutes
                
                if (mm == 8'b01101000) begin // if minutes is 60
                    mm <= 8'b00000000; // reset minutes to 00
                    hh <= hh + 1; // increment hours
                    
                    if (hh == 8'b00010010) begin // if hours is 13
                        hh <= 8'b00000001; // reset hours to 01
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00010011) begin // if hours is 14
                        hh <= 8'b00000010; // reset hours to 02
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00010100) begin // if hours is 15
                        hh <= 8'b00000011; // reset hours to 03
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00010101) begin // if hours is 16
                        hh <= 8'b00000100; // reset hours to 04
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00010110) begin // if hours is 17
                        hh <= 8'b00000101; // reset hours to 05
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00010111) begin // if hours is 18
                        hh <= 8'b00000110; // reset hours to 06
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011000) begin // if hours is 19
                        hh <= 8'b00000111; // reset hours to 07
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011001) begin // if hours is 20
                        hh <= 8'b00001000; // reset hours to 08
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011010) begin // if hours is 21
                        hh <= 8'b00001001; // reset hours to 09
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011011) begin // if hours is 22
                        hh <= 8'b00001010; // reset hours to 10
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011100) begin // if hours is 23
                        hh <= 8'b00001011; // reset hours to 11
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011101) begin // if hours is 24
                        hh <= 8'b00001100; // reset hours to 12
                        pm <= ~pm; // toggle AM/PM
                    end
                end
            end else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
