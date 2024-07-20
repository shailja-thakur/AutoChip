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
        // Seconds
        if (ss == 8'b00111001) begin // 59
            ss <= 8'b00000000;
            // Minutes
            if (mm == 8'b00111001) begin // 59
                mm <= 8'b00000000;
                // Hours
                if (hh == 8'b00010100) begin // 12
                    hh <= 8'b00000001; // 1
                    pm <= ~pm;
                end
                else if (hh == 8'b00010111) begin // 11
                    hh <= 8'b00010100; // 12
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
