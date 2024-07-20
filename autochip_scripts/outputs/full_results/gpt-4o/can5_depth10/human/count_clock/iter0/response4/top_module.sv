module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD count limit constants
    parameter [7:0] MAX_SS = 8'h59; // 59 seconds
    parameter [7:0] MAX_MM = 8'h59; // 59 minutes
    parameter [7:0] MAX_HH_AM = 8'h12; // 12 hours
    parameter [7:0] MAX_HH_PM = 8'h11; // 11 hours before wrap to 12

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            ss <= 0;
            mm <= 0;
            hh <= 8'h12;
            pm <= 0;
        end
        else if (ena) begin
            // Second counter
            if (ss == MAX_SS) begin
                ss <= 0;
                
                // Minute counter
                if (mm == MAX_MM) begin
                    mm <= 0;
                    
                    // Hour counter
                    if (hh == MAX_HH_AM) begin
                        hh <= 8'h01;
                        
                        if (pm) begin
                            // Switch from PM to AM
                            pm <= 0;
                        end else begin
                            pm <= 1;
                        end
                    end else if (hh == MAX_HH_PM) begin
                        hh <= 8'h12;
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
