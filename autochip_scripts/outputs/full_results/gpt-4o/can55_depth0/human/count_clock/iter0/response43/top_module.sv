module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Helper function to increment BCD values
    function [7:0] bcd_increment;
        input [7:0] value;
        if (value[3:0] == 4'h9) begin
            bcd_increment = {value[7:4] + 1'b1, 4'h0};
        end else begin
            bcd_increment = value + 1'b1;
        end
    endfunction

    // Synchronous logic to update clock
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            hh <= 8'h12;   // 12 in BCD
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;    // AM 
        end
        else if (ena) begin
            // Incrementing seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // Incrementing minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Incrementing hours
                    if (hh == 8'h12) begin
                        // 12 goes to 01 and toggles AM/PM
                        hh <= 8'h01;
                        pm <= ~pm;
                    end else if (hh == 8'h09) begin
                        hh <= 8'h10;   // 09 goes to 10 in BCD
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;   // 11 goes to 12 in BCD
                    end else begin
                        // Increment BCD hour, not crossing tens
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
