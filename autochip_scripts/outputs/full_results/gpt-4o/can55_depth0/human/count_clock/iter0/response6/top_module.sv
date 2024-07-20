module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD increment logic
    function [7:0] bcd_increment;
        input [7:0] bcd_value;
        if (bcd_value == 8'h59)
            bcd_increment = 8'h00;
        else if ((bcd_value[3:0] == 4'd9))
            bcd_increment = {bcd_value[7:4] + 1'b1, 4'd0};
        else
            bcd_increment = bcd_value + 1'b1;
    endfunction
    
    // Hours increment logic
    function [7:0] hour_increment;
        input [7:0] hour_value;
        if (hour_value == 8'h12)
            hour_increment = 8'h01;
        else
            hour_increment = bcd_increment(hour_value);
    endfunction

    // State update
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            ss <= bcd_increment(ss);
            if (ss == 8'h59) begin
                // Increment minutes
                mm <= bcd_increment(mm);
                if (mm == 8'h59) begin
                    // Increment hours
                    hh <= hour_increment(hh);
                    if (hh == 8'h11) begin
                        // Toggle AM/PM at 11:59:59
                        pm <= ~pm;
                    end
                end
            end
        end
    end

endmodule
