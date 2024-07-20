module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Helper function to increment BCD value
    function [7:0] bcd_increment(input [7:0] bcd);
        if (bcd[3:0] == 4'd9) begin
            bcd_increment = {bcd[7:4] + 1, 4'd0};
        end else begin
            bcd_increment = bcd + 1;
        end
    endfunction

    // Helper function to check if BCD value is zero
    function [7:0] bcd_zero(input [7:0] bcd);
        bcd_zero = bcd == 8'd0 ? 1 : 0;
    endfunction
    
    // Initialize the time to 12:00 AM
    initial begin
        hh = 8'h12;    // 12 in BCD
        mm = 8'h00;    // 00 in BCD
        ss = 8'h00;    // 00 in BCD
        pm = 1'b0;     // AM
    end

    // Synchronous process to handle the clock logic
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;    // 12 in BCD
            mm <= 8'h00;    // 00 in BCD
            ss <= 8'h00;    // 00 in BCD
            pm <= 1'b0;     // AM
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
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12; // Transition from 11 to 12
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
