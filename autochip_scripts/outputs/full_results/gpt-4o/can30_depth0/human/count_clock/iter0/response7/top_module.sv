module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD Counters for seconds, minutes, and hours
    always @(posedge clk) begin
        if (reset) begin
            // Reset clock to 12:00 AM
            ss <= 8'b00000000;
            mm <= 8'b00000000;
            hh <= 8'b00010010; // 12 in BCD
            pm <= 0;           // AM
        end
        else if (ena) begin
            // Seconds counter
            if (ss == 8'b01011001) begin // 59
                ss <= 8'b00000000;
                
                // Minutes counter
                if (mm == 8'b01011001) begin // 59
                    mm <= 8'b00000000;

                    // Hours counter
                    if (hh == 8'b00010010) begin // 12
                        hh <= 8'b00000001; // 01 in BCD
                        pm <= ~pm;          // Toggle AM/PM
                    end 
                    else if (hh == 8'b00001001) begin // 09 (special transition)
                        hh <= 8'b00010000; // 10 in BCD
                    end 
                    else if (hh == 8'b00010010 - 1) begin // 11 to 12 transition
                        hh <= hh + 1;
                        pm <= ~pm; // Toggle AM/PM
                    end 
                    else begin
                        hh <= hh + 1;
                    end
                end 
                else begin
                    mm <= mm + 1;
                end
            end 
            else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
