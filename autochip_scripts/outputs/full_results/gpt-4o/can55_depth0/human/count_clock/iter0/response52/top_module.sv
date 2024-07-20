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
            hh <= 8'h12; // "12:00 AM"
            pm <= 0;     // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'd9) begin
                if (ss[7:4] == 4'd5) begin
                    ss <= 8'd0;

                    // Increment minutes
                    if (mm[3:0] == 4'd9) begin
                        if (mm[7:4] == 4'd5) begin
                            mm <= 8'd0;

                            // Increment hours
                            if (hh[3:0] == 4'd9 || hh == 8'h12) begin
                                if (hh[7:4] == 4'd1) begin
                                    hh <= 8'h01;
                                    pm <= ~pm;  // Toggle AM/PM
                                end
                                else begin
                                    hh <= hh + 8'h1;
                                end
                            end
                            else begin
                                hh <= hh + 8'h1;
                            end
                        end
                        else begin
                            mm <= mm + 8'h10 - 8'h09; // Increment tens place and reset ones place
                        end
                    end
                    else begin
                        mm <= mm + 1;
                    end
                end
                else begin
                    ss <= ss + 8'h10 - 8'h09; // Increment tens place and reset ones place
                end
            end
            else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
