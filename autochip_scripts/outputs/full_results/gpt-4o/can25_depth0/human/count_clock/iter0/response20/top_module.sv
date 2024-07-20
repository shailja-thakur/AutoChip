module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // BCD increment helper function
    function [7:0] bcd_increment;
        input [7:0] value;
        begin
            if (value[3:0] == 4'b1001) begin // Check if lower nibble is 9
                if (value[7:4] == 4'b1001) // Check if higher nibble is 9
                    bcd_increment = 8'b00000000; // Reset both nibbles
                else
                    bcd_increment = {value[7:4] + 4'b1, 4'b0000}; // Increment higher nibble, reset lower nibble
            end else
                bcd_increment = value + 8'b00000001; // Increment lower nibble
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 1'b0; // AM
        end else if (ena) begin
            // Increment seconds
            ss <= bcd_increment(ss);
            if (ss == 8'b01011001) begin // Check if seconds reach 59
                ss <= 8'b00000000; // Reset seconds
                // Increment minutes
                mm <= bcd_increment(mm); 
                if (mm == 8'b01011001) begin // Check if minutes reach 59
                    mm <= 8'b00000000; // Reset minutes
                    // Increment hours
                    if (hh == 8'b00010010) begin // Check if hours reach 12
                        hh <= 8'b00000001; // Reset hours to 1
                        pm <= ~pm; // Toggle AM/PM indicator
                    end else if (hh == 8'b00001001) begin // Check if hours reach 09
                        hh <= 8'b00010000; // Set hours to 10
                    end else begin
                        hh <= bcd_increment(hh);
                    end
                end
            end
        end
    end

endmodule
