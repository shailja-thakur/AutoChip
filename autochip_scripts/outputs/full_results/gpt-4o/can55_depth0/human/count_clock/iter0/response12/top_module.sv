module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD increment helper function
    function [7:0] bcd_increment;
        input [7:0] bcd;
        begin
            if (bcd[3:0] == 4'd9) begin
                if (bcd[7:4] == 4'd9) begin
                    bcd_increment = 8'd0;
                end else begin
                    bcd_increment = {bcd[7:4] + 4'd1, 4'd0};
                end
            end else begin
                bcd_increment = bcd + 8'd1;
            end
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;   // 12 in BCD
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;       // AM
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;  // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        if (pm) begin
                            hh <= 8'h12;
                        end else begin
                            hh <= 8'h12;
                        end
                    end else begin
                        hh <= bcd_increment(hh);
                    end
                end else begin
                    mm <= bcd_increment(mm);
                end
            end else begin
                ss <= bcd_increment(ss);
            end
        end
    end

endmodule
