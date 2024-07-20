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
            // Reset the time to 12:00 AM
            hh <= 8'h12; // BCD for 12
            mm <= 8'h00; // BCD for 00
            ss <= 8'h00; // BCD for 00
            pm <= 0; // AM
        end else if (ena) begin
            // Increment the seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // Increment the minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Increment the hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h09) begin
                        hh <= hh + 8'h01;
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else if (hh[3:0] == 4'h9) begin
                        hh <= {hh[7:4] + 1'b1, 4'h0};
                    end else begin
                        hh <= hh + 8'h01;
                    end
                end else begin
                    mm <= mm + 8'h01;
                end
            end else begin
                ss <= ss + 8'h01;
            end
        end
    end
endmodule
