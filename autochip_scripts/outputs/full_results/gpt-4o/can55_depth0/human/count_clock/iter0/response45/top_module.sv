module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Parameters for easy readability
    parameter MAX_SECONDS = 8'h59; // 59 seconds
    parameter MAX_MINUTES = 8'h59; // 59 minutes
    parameter MAX_HOURS   = 8'h12; // 12 hours

    always @(posedge clk) begin
        if (reset) begin
            // Resetting the clock to 12:00 AM
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 0;
        end else if (ena) begin
            // Incrementing seconds
            if (ss == MAX_SECONDS) begin
                ss <= 8'h00;
                
                // Incrementing minutes
                if (mm == MAX_MINUTES) begin
                    mm <= 8'h00;
                    
                    // Incrementing hours
                    if (hh == MAX_HOURS) begin
                        hh <= 8'h01; // Roll over to 1
                        pm <= ~pm;   // Toggle AM/PM
                    end else if (hh == 8'h11) begin // Edge case from 11 to 12
                        hh <= 8'h12;
                        pm <= ~pm;   // Toggle AM/PM
                    end else begin
                        hh <= hh + 1;
                    end
                    
                end else begin
                    mm <= mm + 1;
                end
                
            end else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
