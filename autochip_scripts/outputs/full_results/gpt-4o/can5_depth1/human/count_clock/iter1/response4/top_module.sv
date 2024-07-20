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
            hh <= 8'h12;  // 12:00 AM
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;   // AM
        end
        else if (ena) begin
            // Handle seconds increment and rollover
            if (ss == 8'h59) begin
                ss <= 8'h00;
                
                // Handle minutes increment and rollover
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    
                    // Handle hours increment and rollover
                    if (hh == 8'h12) begin
                        hh <= 8'h01;   // Roll over to 1
                        pm <= ~pm;     // Toggle AM/PM
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12;   // Increment 11 to 12
                    end
                    else if (hh[3:0] == 4'd9) begin
                        hh <= {hh[7:4] + 4'd1, 4'd0};  // Handle BCD carry
                    end
                    else begin
                        hh <= hh + 8'd1;  // Simple BCD increment
                    end
                end
                else begin
                    // Simple BCD increment for minutes
                    if (mm[3:0] == 4'd9) begin
                        mm <= {mm[7:4] + 4'd1, 4'd0};
                    end
                    else begin
                        mm <= mm + 8'd1;
                    end
                end
            end
            else begin
                // Simple BCD increment for seconds
                if (ss[3:0] == 4'd9) begin
                    ss <= {ss[7:4] + 4'd1, 4'd0};
                end
                else begin
                    ss <= ss + 8'd1;
                end
            end
        end
    end
endmodule
