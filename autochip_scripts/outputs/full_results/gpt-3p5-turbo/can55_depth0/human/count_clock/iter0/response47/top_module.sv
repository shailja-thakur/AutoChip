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
            pm <= 1'b0; // Reset PM indicator to AM
            hh <= 8'h12; // Reset hours to 12
            mm <= 8'h00; // Reset minutes to 0
            ss <= 8'h00; // Reset seconds to 0
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00; // Reset seconds to 0
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00; // Reset minutes to 0
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01; // Reset hours to 1
                        pm <= ~pm; // Toggle PM indicator
                    end
                    else begin
                        hh <= hh + 1; // Increment hours
                    end
                end
                else begin
                    mm <= mm + 1; // Increment minutes
                end
            end
            else begin
                ss <= ss + 1; // Increment seconds
            end
        end
    end
    
endmodule
