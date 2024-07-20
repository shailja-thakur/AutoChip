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
            // Reset all the counters
            hh <= 8'h12; // 12 in BCD
            mm <= 8'h00; // 00 in BCD
            ss <= 8'h00; // 00 in BCD
            pm <= 1'b0; // AM (pm = 0)
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'd9) begin
                if (ss[7:4] == 4'd5) begin
                    ss <= 8'h00; // Reset seconds to 00
                    
                    // Increment minutes
                    if (mm[3:0] == 4'd9) begin
                        if (mm[7:4] == 4'd5) begin
                            mm <= 8'h00; // Reset minutes to 00
                            
                            // Increment hours
                            if (hh == 8'h12) begin
                                hh <= 8'h01; // 01 in BCD
                                pm <= ~pm;  // Toggle AM/PM
                            end
                            else if (hh == 8'h11) begin
                                hh <= 8'h12; // 12 in BCD
                            end
                            else if (hh[3:0] == 4'd9) begin
                                hh[7:4] <= hh[7:4] + 1;
                                hh[3:0] <= 4'd0;
                            end
                            else begin
                                hh[3:0] <= hh[3:0] + 1;
                            end
                        end
                        else begin
                            mm[7:4] <= mm[7:4] + 1; // Increment tens of minutes
                            mm[3:0] <= 4'd0; // Reset units of minutes
                        end
                    end
                    else begin
                        mm[3:0] <= mm[3:0] + 1; // Increment units of minutes
                    end
                end
                else begin
                    ss[7:4] <= ss[7:4] + 1; // Increment tens of seconds
                    ss[3:0] <= 4'd0; // Reset units of seconds
                end
            end
            else begin
                ss[3:0] <= ss[3:0] + 1; // Increment units of seconds
            end
        end
    end
endmodule
