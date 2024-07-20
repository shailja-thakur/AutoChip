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
        // Seconds
        if (ss == 8'd59) begin
            ss <= 8'd0;
            // Minutes
            if (mm == 8'd59) begin
                mm <= 8'd0;
                // Hours
                if (hh == 8'd12) begin
                    hh <= 8'd1;
                    pm <= ~pm;
                end
                else begin
                    hh <= hh + 8'd1;
                end
            end
            else begin
                mm <= mm + 8'd1;
            end
        end
        else begin
            ss <= ss + 8'd1;
        end
    end
end

endmodule
