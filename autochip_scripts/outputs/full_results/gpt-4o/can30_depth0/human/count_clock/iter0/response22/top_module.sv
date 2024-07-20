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
            // Reset the clock to 12:00:00 AM
            hh <= 8'b0001_0010; // 12
            mm <= 8'b0000_0000; // 00
            ss <= 8'b0000_0000; // 00
            pm <= 1'b0;         // AM
        end else if (ena) begin
            // Increment seconds BCD
            if (ss[3:0] == 4'd9) begin
                ss[3:0] <= 4'd0;
                if (ss[7:4] == 4'd5) begin
                    ss[7:4] <= 4'd0;
                    // Increment minutes BCD
                    if (mm[3:0] == 4'd9) begin
                        mm[3:0] <= 4'd0;
                        if (mm[7:4] == 4'd5) begin
                            mm[7:4] <= 4'd0;
                            // Increment hours BCD
                            if (hh == 8'b0001_0010) begin // 12
                                hh <= 8'b0000_0001; // 01
                                pm <= ~pm; // Toggle AM/PM
                            end else if (hh[3:0] == 4'd9) begin
                                hh[3:0] <= 4'd0;
                                hh[7:4] <= hh[7:4] + 4'd1;
                            end else begin
                                hh[3:0] <= hh[3:0] + 4'd1;
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 4'd1;
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 4'd1;
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 4'd1;
                end
            end else begin
                ss[3:0] <= ss[3:0] + 4'd1;
            end
        end
    end
endmodule
