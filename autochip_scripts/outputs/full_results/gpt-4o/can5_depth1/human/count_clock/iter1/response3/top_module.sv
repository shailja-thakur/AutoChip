module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD increment function for two-digit BCD values
    function [7:0] bcd_increment;
        input [7:0] bcd;
        begin
            if (bcd[3:0] == 4'd9) begin
                if (bcd[7:4] == 4'd9)
                    bcd_increment = 8'd0;
                else
                    bcd_increment = {bcd[7:4] + 4'd1, 4'd0};
            end else begin
                bcd_increment = bcd + 8'd1;
            end
        end
    endfunction

    // Reset values
    parameter BCD_12 = 8'h12;
    parameter BCD_00 = 8'h00;
    parameter BCD_01 = 8'h01;
    
    always @(posedge clk) begin
        if (reset) begin
            hh <= BCD_12;  // Initialize to 12:00 AM
            mm <= BCD_00;
            ss <= BCD_00;
            pm <= 1'b0;    // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'd0;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'd0;
                    // Increment hours
                    if (hh == BCD_12) begin
                        hh <= BCD_01;
                        pm <= ~pm;    // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= BCD_12;
                    end else if (hh[3:0] == 4'd9) begin
                        hh <= {hh[7:4] + 4'd1, 4'd0};  // BCD carry
                    end else begin
                        hh <= hh + 8'd1;
                    end
                end else begin
                    mm <= bcd_increment(mm);
                end
            end else begin
                ss <= bcd_increment(ss);
            end
            
            // Ensure the PM signal is correct at 12:00 PM
            if (hh == BCD_12 && mm == BCD_00 && ss == BCD_00 && ena) begin
                pm <= ~pm;
            end
        end
    end
endmodule
