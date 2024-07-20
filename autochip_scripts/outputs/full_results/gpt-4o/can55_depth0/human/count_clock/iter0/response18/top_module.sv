module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // BCD counters for seconds, minutes, and hours
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end
                    else if (hh == 8'h09) begin
                        hh <= 8'h10;
                    end
                    else if (hh == 8'h19) begin
                        hh <= 8'h20;
                    end
                    else if (hh == 8'h29) begin
                        hh <= 8'h30;
                    end
                    else if (hh == 8'h39) begin
                        hh <= 8'h40;
                    end
                    else if (hh == 8'h49) begin
                        hh <= 8'h50;
                    end
                    else begin
                        hh <= hh + 1;
                    end
                end
                else if (mm[3:0] == 4'h9) begin
                    mm <= {mm[7:4] + 1, 4'h0};
                end
                else begin
                    mm <= mm + 1;
                end
            end
            else if (ss[3:0] == 4'h9) begin
                ss <= {ss[7:4] + 1, 4'h0};
            end
            else begin
                ss <= ss + 1;
            end
        end
    end

endmodule
