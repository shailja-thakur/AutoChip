module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pm <= 1'b0;
            hh <= 8'b0000_1100; // Initialize to 12:00 AM in BCD
            mm <= 8'b0000_0000;
            ss <= 8'b0000_0000;
        end else if (ena) begin
            ss <= ss + 1;
            if (ss >= 8'b0110_0000) begin
                ss <= 8'b0000_0000;
                mm <= mm + 1;
                if (mm >= 8'b0110_0000) begin
                    mm <= 8'b0000_0000;
                    hh <= hh + 1;
                    if (hh >= 8'b0001_0010) begin
                        hh <= 8'b0000_0000;
                        pm <= ~pm;
                    end
                end
            end
        end
    end

endmodule
