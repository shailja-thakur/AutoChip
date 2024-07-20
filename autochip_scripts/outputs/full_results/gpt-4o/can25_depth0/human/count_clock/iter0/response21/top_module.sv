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
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        // Toggle pm/am
                        pm <= ~pm;
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end 
                    else begin
                        // Handle BCD
                        if (hh[3:0] == 4'h9) begin
                            hh[3:0] <= 4'h0;
                            hh[7:4] <= hh[7:4] + 1;
                        end
                        else begin
                            hh <= hh + 1;
                        end
                    end
                end 
                else begin
                    // Handle BCD
                    if (mm[3:0] == 4'h9) begin
                        mm[3:0] <= 4'h0;
                        mm[7:4] <= mm[7:4] + 1;
                    end
                    else begin
                        mm <= mm + 1;
                    end
                end
            end 
            else begin
                // Handle BCD
                if (ss[3:0] == 4'h9) begin
                    ss[3:0] <= 4'h0;
                    ss[7:4] <= ss[7:4] + 1;
                end
                else begin
                    ss <= ss + 1;
                end
            end
        end
    end
endmodule
