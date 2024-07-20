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
        hh <= 8'd12;
        mm <= 8'd0;
        ss <= 8'd0;
        pm <= 0;
    end
    else if (ena) begin
        ss <= (ss == 8'd59) ? 8'd0 : ss + 8'd1;
        if (ss == 8'd59) begin
            mm <= (mm == 8'd59) ? 8'd0 : mm + 8'd1;
            if (mm == 8'd59) begin
                hh <= (hh == 8'd12) ? 8'd1 : hh + 8'd1;
                pm <= (hh == 8'd11) ? ~pm : pm;
            end
        end
    end
end

endmodule
