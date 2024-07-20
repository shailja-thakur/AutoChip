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
            ss <= ss + 1;
            
            if (ss == 8'b01101000) begin // if seconds is 60
                ss <= 8'b00000000; // reset seconds to 00
                mm <= mm + 1; // increment minutes
                
                if (mm == 8'b01101000) begin // if minutes is 60
                    mm <= 8'b00000000; // reset minutes to 00
                    hh <= hh + 1; // increment hours
                    
                    if (hh == 8'b00010010) begin // if hours is 13
                        hh <= 8'b00000001; // reset hours to 01
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh == 8'b00011010) begin // if hours is 22
                        hh <= 8'b00010001; // reset hours to 10
                        pm <= ~pm; // toggle AM/PM
                    end
                end
            end
        end
    end
endmodule
