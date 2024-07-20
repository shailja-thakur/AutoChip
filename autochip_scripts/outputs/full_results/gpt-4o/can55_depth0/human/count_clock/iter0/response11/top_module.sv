module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Helper function to convert BCD to a regular integer
    function integer bcd_to_int(input [7:0] bcd);
        bcd_to_int = (bcd[7:4] * 10) + bcd[3:0];
    endfunction
    
    // Helper function to convert a regular integer to BCD
    function [7:0] int_to_bcd(input integer i);
        int_to_bcd = {(i / 10), (i % 10)};
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
        end else if (ena) begin
            // Seconds counter 
            if (ss[3:0] == 4'd9) begin
                ss[3:0] <= 0;
                if (ss[7:4] == 4'd5) begin
                    ss[7:4] <= 0;
                    // Minutes counter
                    if (mm[3:0] == 4'd9) begin
                        mm[3:0] <= 0;
                        if (mm[7:4] == 4'd5) begin
                            mm[7:4] <= 0;
                            // Hours counter
                            if (hh == 8'h12) begin
                                hh <= 8'h01;
                                pm <= ~pm; // Toggle AM/PM
                            end else if (hh[3:0] == 4'h9) begin
                                hh[3:0] <= 0;
                                hh[7:4] <= hh[7:4] + 1;
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
