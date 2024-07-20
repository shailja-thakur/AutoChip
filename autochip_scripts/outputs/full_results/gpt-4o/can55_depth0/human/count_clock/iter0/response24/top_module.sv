module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD decade counter function
    function [7:0] bcd_counter;
        input [7:0] value;
        input [7:0] max_bcd;
        begin
            if (value[3:0] == 4'd9) begin // If the unit digit is 9
                value[3:0] = 4'd0;        // Reset unit digit to 0
                if (value[7:4] == max_bcd[7:4]) begin // If the tens digit is at max BCD limit
                    value[7:4] = 4'd0;    // Reset tens digit to 0
                end else begin
                    value[7:4] = value[7:4] + 1'b1; // Increment tens digit
                end
            end else begin
                value[3:0] = value[3:0] + 1'b1; // Otherwise just increment unit digit
            end
            bcd_counter = value;
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // 12:00 AM (12 in BCD)
            mm <= 8'h00; // 00
            ss <= 8'h00; // 00
            pm <= 0; // AM
        end else if (ena) begin
            // Seconds counter
            ss <= bcd_counter(ss, 8'h59);
            
            // If seconds overflowed, increment minutes
            if (ss == 8'h59) begin
                ss <= 8'h00;
                mm <= bcd_counter(mm, 8'h59);

                // If minutes overflowed, increment hours
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    if ((hh[3:0] == 4'd2 && hh[7:4] == 4'd1) || (hh == 8'h12)) begin
                        hh <= 8'h01; // if hour reaches 12, reset to 1
                        pm <= ~pm; // toggle AM/PM
                    end else if (hh[3:0] == 4'd9) begin
                        hh[3:0] <= 4'd0;
                        hh[7:4] <= hh[7:4] + 1'b1;
                    end else begin
                        hh[3:0] <= hh[3:0] + 1'b1;
                    end
                end
            end
        end
    end
endmodule
