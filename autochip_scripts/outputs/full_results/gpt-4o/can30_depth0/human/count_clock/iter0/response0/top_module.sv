module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Converts BCD to binary value
    function integer bcd2bin;
        input [7:0] bcd;
        bcd2bin = (bcd[7:4] * 10) + bcd[3:0];
    endfunction

    // Converts binary value to BCD
    function [7:0] bin2bcd;
        input integer bin;
        bin2bcd = {4'b0, bin % 10} | ({4'b0, bin / 10} << 4);
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            hh <= 8'h12; // 12
            mm <= 8'h00; // 00
            ss <= 8'h00; // 00
            pm <= 0;     // AM
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle PM/AM
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
                    end else begin
                        hh <= bin2bcd(bcd2bin(hh) + 1);
                    end
                end else begin
                    mm <= bin2bcd(bcd2bin(mm) + 1);
                end
            end else begin
                ss <= bin2bcd(bcd2bin(ss) + 1);
            end
        end
    end
endmodule
