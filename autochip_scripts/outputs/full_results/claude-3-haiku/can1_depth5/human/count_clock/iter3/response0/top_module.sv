module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [3:0] hh,
    output reg [3:0] mm,
    output reg [3:0] ss
);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 4'd1;
            mm <= 4'd0;
            ss <= 4'd0;
            pm <= 0;
        end
        else if (ena) begin
            // Seconds
            if (ss == 4'd59) begin
                ss <= 4'd0;
                // Minutes
                if (mm == 4'd59) begin
                    mm <= 4'd0;
                    // Hours
                    if (hh == 4'd12) begin
                        hh <= 4'd1;
                        pm <= ~pm;
                    end
                    else begin
                        hh <= hh + 4'd1;
                    end
                end
                else begin
                    mm <= mm + 4'd1;
                end
            end
            else begin
                ss <= ss + 4'd1;
            end
        end
    end

endmodule
