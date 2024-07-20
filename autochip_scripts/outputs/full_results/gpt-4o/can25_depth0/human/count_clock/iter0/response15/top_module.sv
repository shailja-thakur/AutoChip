module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Define constants for BCD limits and midnight/noon reset values
    localparam BCD_LIMIT = 8'h59;
    localparam BCD_HOUR_LIMIT = 8'h12;
    localparam MIDNIGHT = 8'h12;
    localparam NOON_RESET = 8'h12;

    // Initialize the clock state
    always @(posedge clk) begin
        if (reset) begin
            // Reset clock to 12:00:00 AM
            hh <= MIDNIGHT;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss == BCD_LIMIT) begin
                ss <= 8'h00;

                // Increment minutes
                if (mm == BCD_LIMIT) begin
                    mm <= 8'h00;

                    // Increment hours and toggle PM indicator if necessary
                    if (hh == BCD_HOUR_LIMIT) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end 
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end
                    else begin
                        hh <= hh + 8'h01;
                    end
                end
                else begin
                    mm <= mm + 8'h01;
                end
            end
            else begin
                ss <= ss + 8'h01;
            end
        end
    end
endmodule
