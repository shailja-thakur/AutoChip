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
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment the seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment the minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment the hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end
                    else if (hh[3:0] == 4'h9) begin
                        hh <= {hh[7:4] + 4'h1, 4'h0};  // Increment tens place
                    end
                    else begin
                        hh <= hh + 8'h01;
                    end
                end
                else if (mm[3:0] == 4'h9) begin
                    mm <= {mm[7:4] + 4'h1, 4'h0};  // Increment tens place
                end
                else begin
                    mm <= mm + 8'h01;
                end
            end
            else if (ss[3:0] == 4'h9) begin
                ss <= {ss[7:4] + 4'h1, 4'h0};  // Increment tens place
            end
            else begin
                ss <= ss + 8'h01;
            end
        end
    end
endmodule
