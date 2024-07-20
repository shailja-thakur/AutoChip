module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] hh_bcd;
    reg [7:0] mm_bcd;
    reg [7:0] ss_bcd;

    always @(posedge clk) begin
        if (reset) begin
            hh_bcd <= 8'b00000000; // 00
            mm_bcd <= 8'b00000000; // 00
            ss_bcd <= 8'b00000000; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            if (ss_bcd >= 8'b00110000) begin
                ss_bcd <= 8'b00000000; // reset seconds
                mm_bcd <= mm_bcd + 1;
                if (mm_bcd >= 8'b01100000) begin
                    mm_bcd <= 8'b00000000; // reset minutes
                    hh_bcd <= hh_bcd + 1;
                    if (hh_bcd >= 8'b00011000) begin
                        hh_bcd <= 8'b00000001; // reset hours
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end else begin
                ss_bcd <= ss_bcd + 1;
            end
        end
    end

    // BCD to Binary conversion
    always @* begin
        if (hh_bcd >= 8'b00110000) begin
            hh = (hh_bcd[7:4] - 8'b0011) * 10 + (hh_bcd[3:0]);
        end else begin
            hh = hh_bcd;
        end
        if (mm_bcd >= 8'b01100000) begin
            mm = (mm_bcd[7:4] - 8'b0110) * 10 + (mm_bcd[3:0]);
        end else begin
            mm = mm_bcd;
        end
        if (ss_bcd >= 8'b01100000) begin
            ss = (ss_bcd[7:4] - 8'b0110) * 10 + (ss_bcd[3:0]);
        end else begin
            ss = ss_bcd;
        end
    end

endmodule
