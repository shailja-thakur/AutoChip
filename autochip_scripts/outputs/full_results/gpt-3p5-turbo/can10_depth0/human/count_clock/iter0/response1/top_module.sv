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
        hh <= 8'b00000000;
        mm <= 8'b00000000;
        ss <= 8'b00000000;
    end else if (ena) begin
        ss <= ss + 1;
        if (ss == 8'b01101000) begin
            mm <= mm + 1;
            ss <= 8'b00000000;
            if (mm == 8'b01101000) begin
                hh <= hh + 1;
                mm <= 8'b00000000;
                if (hh == 8'b00011010) begin
                    pm <= ~pm;
                    hh <= 8'b00000000;
                end
            end
        end
    end
end

endmodule
