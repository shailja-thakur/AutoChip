module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Helper function to increment BCD
    function [7:0] bcd_increment;
        input [7:0] bcd_in;
        begin
            if (bcd_in[3:0] == 4'd9) begin
                bcd_increment[3:0] = 4'd0;
                bcd_increment[7:4] = bcd_in[7:4] + 4'd1;
            end else begin
                bcd_increment = bcd_in + 8'd1;
            end
            if (bcd_increment[7:4] == 4'd10) begin
                bcd_increment[7:4] = 4'd0;
            end
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 1'b0;
        end else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'd9 && ss[7:4] == 4'd5) begin
                ss <= 8'h00;
                
                // Increment minutes
                if (mm[3:0] == 4'd9 && mm[7:4] == 4'd5) begin
                    mm <= 8'h00;
                    
                    // Increment hours
                    if (hh[7:4] == 4'd1 && hh[3:0] == 4'd2) begin
                        hh <= 8'h01;
                        pm <= ~pm;
                    end else if (hh == 8'h11) begin
                        hh <= 8'h12;
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
