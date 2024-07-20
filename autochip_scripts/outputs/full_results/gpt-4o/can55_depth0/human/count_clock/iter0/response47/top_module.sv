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
            ss <= 8'b00000000;
            mm <= 8'b00000000;
            hh <= 8'b00010010;  // 12 in BCD
            pm <= 1'b0;         // AM
        end 
        else if (ena) begin
            // Seconds counter
            if (ss == 8'b01011001) begin  // 59 in BCD
                ss <= 0;
                // Minutes counter
                if (mm == 8'b01011001) begin  // 59 in BCD
                    mm <= 0;
                    // Hours counter
                    if (hh == 8'b00010010) begin  // 12 in BCD
                        hh <= 8'b00000001;  // 1 in BCD
                        pm <= ~pm;          // Toggle AM/PM
                    end else if (hh == 8'b00001001) begin  // 9 in BCD
                        hh <= hh + 7;      // jump from 09 to 10
                    end else begin
                        hh <= hh + 1;
                    end
                end else if ((mm & 8'b00001111) == 4'b1001) begin // For BCD, if mm[3:0] == 9
                    mm <= mm + 8'b00010110;  // Add 6 to carry over to the next BCD digit
                end else begin
                    mm <= mm + 1;
                end
            end else if ((ss & 8'b00001111) == 4'b1001) begin // For BCD, if ss[3:0] == 9
                ss <= ss + 8'b00010110;  // Add 6 to carry over to the next BCD digit
            end else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
