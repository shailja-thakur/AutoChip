module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

always @(posedge clk) begin
    if (reset) begin
        hh <= 8'h12; // 12 AM
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 0;
    end
    else if (ena) begin
        // Increment seconds
        if (ss == 8'h59) begin // 59 seconds
            ss <= 8'h00;
            // Increment minutes
            if (mm == 8'h59) begin // 59 minutes
                mm <= 8'h00;
                // Increment hours
                if (hh == 8'h12) begin // 12 hours
                    hh <= 8'h01; // 1 hour
                    pm <= ~pm; // Toggle AM/PM
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
