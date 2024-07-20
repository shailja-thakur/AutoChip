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
            hh <= 8'hab; // 12
            mm <= 8'h00; // 00
            ss <= 8'h00; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            ss <= ss + 1;
            if (ss == 8'h59) begin
                ss <= 8'h00; // reset seconds
                mm <= mm + 1;
                if (mm == 8'h59) begin
                    mm <= 8'h00; // reset minutes
                    hh <= hh + 1;
                    if (hh == 8'h12) begin
                        hh <= 8'h01; // reset hours
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end
        end
    end
       
endmodule
