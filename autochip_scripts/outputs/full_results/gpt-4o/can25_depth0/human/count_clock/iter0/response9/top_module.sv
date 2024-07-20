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
            ss <= 8'd0;
            mm <= 8'd0;
            hh <= 8'h12;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'd0;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'd0;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;
                    end
                    else if (hh == 8'h11) begin
                        hh <= 8'h12; // Roll back to 12
                    end
                    else begin
                        if (hh[3:0] == 4'b1001)
                            hh <= {hh[7:4] + 1'b1, 4'b0000};
                        else
                            hh <= hh + 8'b0000_0001;
                    end
                end
                else begin
                    if (mm[3:0] == 4'b1001)
                        mm <= {mm[7:4] + 1'b1, 4'b0000};
                    else
                        mm <= mm + 8'b0000_0001;
                end
            end
            else begin
                if (ss[3:0] == 4'b1001)
                    ss <= {ss[7:4] + 1'b1, 4'b0000};
                else
                    ss <= ss + 8'b0000_0001;
            end
        end
    end

endmodule
