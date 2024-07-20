module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD increment function
    function [7:0] bcd_increment;
        input [7:0] bcd_value;
        begin
            if (bcd_value[3:0] == 4'd9) begin
                bcd_increment[3:0] = 4'd0;
                bcd_increment[7:4] = bcd_value[7:4] + 4'd1;
            end else begin
                bcd_increment = bcd_value + 8'd1;
            end

            if (bcd_increment[7:4] == 4'd10) begin
                bcd_increment[7:4] = 4'd0;
            end
        end
    endfunction

    // Synchronous logic to handle reset and enable
    always @(posedge clk) begin
        if (reset) begin
            // Reset all counters and PM indicator
            hh <= 8'h12; // 12:00 AM
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;
                    end else if (hh == 8'h11) begin
                        hh <= hh + 8'h01;
                        pm <= 1'b0; // Switch to AM
                    end else begin
                        hh <= bcd_increment(hh);
                    end
                end else begin
                    mm <= bcd_increment(mm);
                end
            end else begin
                ss <= bcd_increment(ss);
            end
        end
    end
endmodule
