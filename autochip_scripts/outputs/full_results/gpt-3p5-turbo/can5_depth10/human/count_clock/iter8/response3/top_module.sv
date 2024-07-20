module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] ss_count;
    reg [7:0] mm_count;
    reg [7:0] hh_count;

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12
            mm <= 8'b00000000; // 00
            ss <= 8'b00000000; // 00
            ss_count <= 8'b00000000;
            mm_count <= 8'b00000000;
            hh_count <= 8'b00010010;
            pm <= 1'b0; // AM
        end else begin
            if (ena) begin
                ss_count <= ss_count + 1;
                if (ss_count == 8'b01111111) begin
                    ss_count <= 8'b00000000; // reset seconds count
                    mm_count <= mm_count + 1;
                    if (mm_count == 8'b01101101) begin // adjust BCD representation for minutes to 59 (decimal value)
                        mm_count <= 8'b00000000; // reset minutes count
                        hh_count <= hh_count + 1;
                        if (hh_count == 8'b00011011) begin // adjust BCD representation for hours to 12 (decimal value)
                            hh_count <= 8'b00000001; // reset hours count
                            pm <= ~pm; // toggle AM/PM indicator
                        end
                    end
                end
            end
            ss <= {ss_count[6:4], ss_count[3:0]};
            mm <= {mm_count[6:4], mm_count[3:0]};
            hh <= {pm, hh_count[4:0]};
        end
    end

endmodule
