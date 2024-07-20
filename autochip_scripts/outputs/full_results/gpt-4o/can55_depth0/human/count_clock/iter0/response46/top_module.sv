module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // 12-hour clock counter logic
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'b00000000; // 00 seconds
            mm <= 8'b00000000; // 00 minutes
            hh <= 8'b00010010; // 12 hours in BCD
            pm <= 1'b0;        // AM
        end else if (ena) begin
            if (ss[3:0] == 9) begin
                ss[3:0] <= 0;
                if (ss[7:4] == 5) begin
                    ss[7:4] <= 0;
                    if (mm[3:0] == 9) begin
                        mm[3:0] <= 0;
                        if (mm[7:4] == 5) begin
                            mm[7:4] <= 0;
                            if (hh[3:0] == 9) begin
                                hh[3:0] <= 0;
                                if (hh[7:4] == 1 && hh[3:0] == 2) begin
                                    hh <= 8'b00000001; // reset to 01 hour
                                    pm <= ~pm;         // toggle AM/PM
                                end else if (hh[7:4] == 0) begin
                                    hh[7:4] <= 1;
                                    hh[3:0] <= hh[3:0] + 1;
                                end
                            end else begin
                                hh[3:0] <= hh[3:0] + 1;
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 1;
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 1;
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 1;
                end
            end else begin
                ss[3:0] <= ss[3:0] + 1;
            end
        end
    end
endmodule
