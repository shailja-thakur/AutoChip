module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // BCD increment function
    function [7:0] bcd_increment;
        input [7:0] value;
        begin
            if (value[3:0] == 4'd9) begin
                if (value[7:4] == 4'd9)
                    bcd_increment = 8'd0;
                else
                    bcd_increment = {value[7:4] + 4'd1, 4'd0};
            end else
                bcd_increment = value + 8'd1;
        end
    endfunction

    // Initialize
    initial begin
        hh = 8'h12; // 12 in BCD
        mm = 8'h00; // 00 in BCD
        ss = 8'h00; // 00 in BCD
        pm = 0; // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm;
                    end else if (hh == 8'h11) begin
                        hh <= hh + 8'd1;
                    end else if (hh[3:0] == 4'd9) begin
                        hh <= {hh[7:4] + 4'd1, 4'd0}; 
                    end else begin
                        hh <= hh + 8'd1;
                    end

                end else begin
                    mm <= mm + 8'd1;
                end

            end else begin
                ss <= ss + 8'd1;
            end
        end
    end
endmodule
