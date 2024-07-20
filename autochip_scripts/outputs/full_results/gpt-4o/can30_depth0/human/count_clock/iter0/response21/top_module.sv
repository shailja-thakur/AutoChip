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
            // Reset to 12:00:00 AM
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;
                    end else if (hh == 8'h09 || hh == 8'h8) begin
                        hh <= hh + 8'h10; // Correcting increment on BCD boundary
                    end else if (hh == 8'h09) begin
                        hh <= 8'h10;
                    end else begin
                        hh <= hh + 8'h01;
                    end
                end else begin
                    if ((mm & 8'h0F) == 8'h09) begin
                        mm <= {mm[7:4] + 1, 4'h0}; // Correcting increment on BCD boundary
                    end else begin
                        mm <= mm + 8'h01;
                    end
                end
            end else begin
                if ((ss & 8'h0F) == 8'h09) begin
                    ss <= {ss[7:4] + 1, 4'h0}; // Correcting increment on BCD boundary
                end else begin
                    ss <= ss + 8'h01;
                end
            end
        end
    end

endmodule
