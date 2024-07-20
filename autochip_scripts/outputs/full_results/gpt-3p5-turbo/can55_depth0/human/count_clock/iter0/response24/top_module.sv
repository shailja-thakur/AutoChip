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
        hh <= 8'b00010010;    // Set hours to "12"
        mm <= 8'b00000000;    // Set minutes to "00"
        ss <= 8'b00000000;    // Set seconds to "00"
        pm <= 1'b0;           // Set AM indicator
    end else if (ena) begin
        ss <= ss + 1;         // Increment seconds
        if (ss == 8'b01111010) begin
            ss <= 8'b00000000;    // Reset seconds to "00"
            mm <= mm + 1;         // Increment minutes
            if (mm == 8'b01111010) begin
                mm <= 8'b00000000;    // Reset minutes to "00"
                hh <= hh + 1;         // Increment hours
                if (hh == 8'b00011001) begin
                    hh <= 8'b00000001;    // Reset hours to "01"
                    pm <= ~pm;            // Toggle AM/PM indicator
                end
            end
        end
    end
end

endmodule
