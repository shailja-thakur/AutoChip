module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

// Constants for BCD counters
parameter SECS_MAX = 59;
parameter MINS_MAX = 59;
parameter HOURS_MAX = 12;

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 1'b0;
    end
    else if (ena) begin
        // Increment the seconds counter
        if (ss == SECS_MAX) begin
            ss <= 8'h00;
            // Increment the minutes counter
            if (mm == MINS_MAX) begin
                mm <= 8'h00;
                // Increment the hours counter
                if (hh == HOURS_MAX) begin
                    hh <= 8'h01;
                    // Toggle the AM/PM indicator
                    pm <= ~pm;
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
