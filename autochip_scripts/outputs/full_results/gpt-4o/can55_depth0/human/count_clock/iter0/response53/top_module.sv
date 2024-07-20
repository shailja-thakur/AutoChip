module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;  // 12 hours (BCD)
            mm <= 8'h00;  // 00 minutes (BCD)
            ss <= 8'h00;  // 00 seconds (BCD)
            pm <= 0;  // AM
        end
        else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end
                    else if (hh[3:0] == 4'h9) begin
                        hh <= {hh[7:4] + 1'b1, 4'h0};
                    end
                    else begin
                        hh <= hh + 1'b1;
                    end
                end
                else if (mm[3:0] == 4'h9) begin
                    mm <= {mm[7:4] + 1'b1, 4'h0};
                end
                else begin
                    mm <= mm + 1'b1;
                end
            end
            else if (ss[3:0] == 4'h9) begin
                ss <= {ss[7:4] + 1'b1, 4'h0};
            end
            else begin
                ss <= ss + 1'b1;
            end
        end
    end
endmodule
