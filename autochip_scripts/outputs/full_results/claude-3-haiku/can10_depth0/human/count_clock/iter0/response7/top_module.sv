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
        hh <= 8'b00010000; // 12:00 AM
        mm <= 8'b00000000;
        ss <= 8'b00000000;
        pm <= 0;
    end
    else if (ena) begin
        // Increment seconds
        if (ss == 8'b00111001) begin // 59 in BCD
            ss <= 8'b00000000;
            // Increment minutes
            if (mm == 8'b00111001) begin // 59 in BCD
                mm <= 8'b00000000;
                // Increment hours
                if (hh == 8'b00010010) begin // 12 in BCD
                    hh <= 8'b00010001; // 01 in BCD
                    pm <= ~pm;
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
