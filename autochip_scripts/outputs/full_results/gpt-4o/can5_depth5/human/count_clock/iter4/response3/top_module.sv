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
            hh <= 8'h12;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'b00000000;

                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'b00000000;

                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM every 12 hours
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
    
    always @(posedge clk) begin
        if (reset) begin
            pm <= 1'b0;
        end else if (ena && hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
            pm <= ~pm;
        end
    end
endmodule
