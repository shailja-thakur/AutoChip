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
            // Reset all the counters
            hh <= 8'h12; // 12 in BCD
            mm <= 8'h00; // 00 in BCD
            ss <= 8'h00; // 00 in BCD
            pm <= 1'b0;  // AM (pm = 0)
        end
        else if (ena) begin
            // Check if seconds reaches 59
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end
                    else begin
                        if (hh[3:0] == 4'd9) begin
                            hh[3:0] <= 4'd0;
                            hh[7:4] <= hh[7:4] + 4'd1;
                        end
                        else begin
                            hh[3:0] <= hh[3:0] + 4'd1;
                        end
                    end
                end
                else begin
                    if (mm[3:0] == 4'd9) begin
                        mm[3:0] <= 4'd0;
                        mm[7:4] <= mm[7:4] + 4'd1;
                    end
                    else begin
                        mm[3:0] <= mm[3:0] + 4'd1;
                    end
                end
            end
            else begin
                if (ss[3:0] == 4'd9) begin
                    ss[3:0] <= 4'd0;
                    ss[7:4] <= ss[7:4] + 4'd1;
                end
                else begin
                    ss[3:0] <= ss[3:0] + 4'd1;
                end
            end
        end
    end
endmodule
