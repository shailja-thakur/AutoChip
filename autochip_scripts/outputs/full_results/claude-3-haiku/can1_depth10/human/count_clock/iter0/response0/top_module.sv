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
        hh <= 8'b00010100; // 12 AM
        mm <= 8'b00000000;
        ss <= 8'b00000000;
        pm <= 0;
    end
    else if (ena) begin
        // Increment seconds
        if (ss == 8'b00111001) begin // 59 seconds
            ss <= 8'b00000000;
            // Increment minutes
            if (mm == 8'b00111001) begin // 59 minutes
                mm <= 8'b00000000;
                // Increment hours
                if (hh == 8'b00010100) begin // 12 hours
                    hh <= 8'b00000001; // 1 hour
                    pm <= ~pm; // Toggle AM/PM
                end
                else begin
                    hh <= hh + 8'b00000001;
                end
            end
            else begin
                mm <= mm + 8'b00000001;
            end
        end
        else begin
            ss <= ss + 8'b00000001;
        end
    end
end

endmodule
