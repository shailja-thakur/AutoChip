module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

// Define the maximum values for each counter
parameter MAX_SS = 59;
parameter MAX_MM = 59;
parameter MAX_HH = 12;

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 0; // AM
    end
    else if (ena) begin
        // Increment the seconds counter
        if (ss == MAX_SS) begin
            ss <= 8'h00;
            // Increment the minutes counter
            if (mm == MAX_MM) begin
                mm <= 8'h00;
                // Increment the hours counter
                if (hh == MAX_HH) begin
                    hh <= 8'h01;
                    pm <= ~pm; // Toggle the AM/PM indicator
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
