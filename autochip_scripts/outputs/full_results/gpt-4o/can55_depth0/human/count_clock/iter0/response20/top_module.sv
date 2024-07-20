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
            hh <= 8'h12; // BCD for 12
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;  // AM
        end else if (ena) begin
            // Increase seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                
                // Increase minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    
                    // Increase hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else if ((hh & 8'h0F) == 8'h09) begin
                        hh <= {hh[7:4] + 4'd1, 4'h0}; // BCD carry
                    else
                        hh <= hh + 1'b1;
                    end
                end else if ((mm & 8'h0F) == 8'h09) begin
                    mm <= {mm[7:4] + 4'd1, 4'h0}; // BCD carry
                else
                    mm <= mm + 1'b1;
                end
            end else if ((ss & 8'h0F) == 8'h09) begin
                ss <= {ss[7:4] + 4'd1, 4'h0}; // BCD carry
            else
                ss <= ss + 1'b1;
            end
        end
    end
endmodule
