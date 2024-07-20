module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] bcd_hh;
    reg [5:0] bcd_mm;
    reg [5:0] bcd_ss;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh <= 8'b00010010; // 12
            mm <= 8'b00000000; // 00
            ss <= 8'b00000000; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            if (bcd_ss == 6'b011000) begin
                bcd_ss <= 6'b000000; // reset seconds
                bcd_mm <= bcd_mm + 1;
                if (bcd_mm >= 6'b110000) begin
                    bcd_mm <= 6'b000000; // reset minutes
                    bcd_hh <= bcd_hh + 1;
                    if (bcd_hh >= 4'b1011) begin
                        bcd_hh <= 4'b0001; // reset hours
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end else begin
                bcd_ss <= bcd_ss + 1;
            end
        end
    end

    assign hh = {2'b0, bcd_hh};
    assign mm = {1'b0, bcd_mm};
    assign ss = {1'b0, bcd_ss};

endmodule
