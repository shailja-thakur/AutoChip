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
        pm <= 1'b0;
        hh <= 8'b00010010;
        mm <= 8'b00000000;
        ss <= 8'b00000000;
    end else if (ena) begin
        ss <= ss + 1;
        if (ss == 8'b01101010) begin
            ss <= 8'b00000000;
            mm <= mm + 1;
            if (mm == 8'b01101010) begin
                mm <= 8'b00000000;
                hh <= hh + 1;
                if (hh == 8'b00011010) begin
                    pm <= ~pm;
                    hh <= 8'b00000001;
                end else if (hh == 8'b00110010) begin
                    hh <= 8'b00000000;
                end
            end
        end
    end
end

endmodule
