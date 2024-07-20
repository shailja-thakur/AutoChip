module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Helper function to increment BCD
    function [7:0] bcd_increment;
        input [7:0] value;
        begin
            if (value[3:0] == 4'd9) begin
                bcd_increment = {value[7:4] + 4'd1, 4'd0};
            end
            else begin
                bcd_increment = value + 4'd1;
            end
        end
    endfunction

    // State for the clock
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // 12:00 AM
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Handle seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // Handle minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Handle hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
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
