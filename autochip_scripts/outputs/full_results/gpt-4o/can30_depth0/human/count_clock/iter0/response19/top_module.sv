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
            // Reset clock to "12:00 AM"
            hh <= 8'h12; // 12 in BCD
            mm <= 8'h00; // 00 in BCD
            ss <= 8'h00; // 00 in BCD
            pm <= 0;
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
                        hh <= 8'h10; // 09 -> 10 in BCD
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12; 
                    end
                    else begin
                        hh <= hh + 8'h01;
                    end
                end
                else if (mm[3:0] == 4'h9) begin
                    mm <= {mm[7:4] + 4'h1, 4'h0};
                end
                else begin
                    mm <= mm + 8'h01;
                end
            end
            else if (ss[3:0] == 4'h9) begin
                ss <= {ss[7:4] + 4'h1, 4'h0};
            end
            else begin
                ss <= ss + 8'h01;
            end
        end
    end
endmodule
