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
            hh <= 8'h12;     // 12 in BCD
            mm <= 8'h00;     // 00 in BCD
            ss <= 8'h00;     // 00 in BCD
            pm <= 0;         // AM
        end
        else if (ena) begin
            // Seconds counter
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // Minutes counter
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Hours counter
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle am/pm
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end
                    else begin
                        hh <= hh + 8'h01;
                    end
                end
                else begin
                    mm <= mm + 8'h01;
                end
            end
            else begin
                ss <= ss + 8'h01;
            end
        end
    end
endmodule
