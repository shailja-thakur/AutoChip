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
            pm <= 0;
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else begin
                        if (hh[3:0] == 4'h9) // If LSB is 9
                            hh <= hh + 8'h07; // increment tens digit
                        else
                            hh <= hh + 8'h01; // increment units digit
                    end 
                end else begin
                    if (mm[3:0] == 4'h9) // If LSB is 9
                        mm <= mm + 8'h07; // increment tens digit
                    else
                        mm <= mm + 8'h01; // increment units digit
                end
            end else begin
                if (ss[3:0] == 4'h9) // If LSB is 9
                    ss <= ss + 8'h07; // increment tens digit
                else
                    ss <= ss + 8'h01; // increment units digit
            end
        end
    end
endmodule
