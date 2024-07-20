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
            // Reset to 12:00 AM
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end else if (hh == 8'h09) begin
                        hh <= 8'h10;
                    end else if (hh[3:0] == 4'h9) begin
                        hh <= hh + 8'h07;  // Adjust for BCD
                    end else begin
                        hh <= hh + 8'h01;
                    end
                end else if (mm[3:0] == 4'h9) begin
                    mm <= mm + 8'h07;  // Adjust for BCD
                end else begin
                    mm <= mm + 8'h01;
                end
            end else if (ss[3:0] == 4'h9) begin
                ss <= ss + 8'h07;  // Adjust for BCD
            end else begin
                ss <= ss + 8'h01;
            end
        end
    end
endmodule
