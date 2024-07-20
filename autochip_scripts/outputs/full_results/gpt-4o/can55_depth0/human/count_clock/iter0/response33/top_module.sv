module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Define BCD limits
    parameter MAX_SS = 8'h59;
    parameter MAX_MM = 8'h59;
    parameter MAX_HH = 8'h12;
    
    // Helper function to increment BCD values
    function [7:0] bcd_increment;
        input [7:0] bcd_in;
        if (bcd_in[3:0] == 4'h9) begin
            bcd_increment = {bcd_in[7:4] + 4'd1, 4'h0};
        end
        else begin
            bcd_increment = bcd_in + 8'h01;
        end
    endfunction

    // Reset or increment logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset the clock to 12:00:00 AM
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end
        else if (ena) begin
            if (ss == MAX_SS) begin
                ss <= 8'h00;
                if (mm == MAX_MM) begin
                    mm <= 8'h00;
                    if (hh == MAX_HH) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end
                    else if (hh == 8'h11) begin
                        hh <= hh + 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end
                    else begin
                        hh <= bcd_increment(hh);
                    end
                end
                else begin
                    mm <= bcd_increment(mm);
                end
            end
            else begin
                ss <= bcd_increment(ss);
            end
        end
    end
endmodule
