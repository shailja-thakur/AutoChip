module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [2:0] hours_tens;
    reg [3:0] hours_ones;
    reg [3:0] minutes_tens;
    reg [6:0] minutes_ones;
    reg [3:0] seconds_tens;
    reg [6:0] seconds_ones;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hours_tens <= 3'b0;
            hours_ones <= 4'b0;
            minutes_tens <= 4'b0;
            minutes_ones <= 7'b0;
            seconds_tens <= 4'b0;
            seconds_ones <= 7'b0;
            pm <= 1'b0;
        end else if (ena) begin
            if (seconds_ones == 7'b1001101) begin
                seconds_ones <= 7'b0;
                if (minutes_ones == 7'b101101) begin
                    minutes_ones <= 7'b0;
                    if (hours_ones == 4'b1101) begin
                        hours_ones <= 4'b0;
                        if (hours_tens == 3'b101) begin
                            hours_tens <= 3'b0;
                            pm <= ~pm;
                        end else begin
                            hours_tens <= hours_tens + 1;
                        end
                    end else begin
                        hours_ones <= hours_ones + 1;
                    end
                end else begin
                    minutes_ones <= minutes_ones + 1;
                end
            end else begin
                seconds_ones <= seconds_ones + 1;
            end
        end
    end
    
    always @* begin
        case (hours_tens)
            3'b0: hh = 8'b00000000; // 12
            3'b1: hh = 8'b00010000; // 01
            3'b10: hh = 8'b00100000; // 02
            3'b11: hh = 8'b00110000; // 03
            3'b100: hh = 8'b01000000; // 04
            3'b101: hh = 8'b01010000; // 05
            3'b110: hh = 8'b01100000; // 06
            3'b111: hh = 8'b01110000; // 07
        endcase

        case (hours_ones)
            4'b0: hh[3:0] = 4'b0000;
            4'b1: hh[3:0] = 4'b0001;
            4'b10: hh[3:0] = 4'b0010;
            4'b11: hh[3:0] = 4'b0011;
            4'b100: hh[3:0] = 4'b0100;
            4'b101: hh[3:0] = 4'b0101;
            4'b110: hh[3:0] = 4'b0110;
            4'b111: hh[3:0] = 4'b0111;
            4'b1000: hh[3:0] = 4'b1000;
            4'b1001: hh[3:0] = 4'b1001;
            4'b1010: hh[3:0] = 4'b1010;
            4'b1011: hh[3:0] = 4'b1011;
        endcase

        case (minutes_tens)
            4'b0: mm[7:4] = 4'b0000;
            4'b1: mm[7:4] = 4'b0001;
            4'b10: mm[7:4] = 4'b0010;
            4'b11: mm[7:4] = 4'b0011;
            4'b100: mm[7:4] = 4'b0100;
            4'b101: mm[7:4] = 4'b0101;
        endcase

        case (minutes_ones)
            7'b0: mm[3:0] = 4'b0000;
            7'b1: mm[3:0] = 4'b0001;
            7'b10: mm[3:0] = 4'b0010;
            7'b11: mm[3:0] = 4'b0011;
            7'b100: mm[3:0] = 4'b0100;
            7'b101: mm[3:0] = 4'b0101;
            7'b110: mm[3:0] = 4'b0110;
            7'b111: mm[3:0] = 4'b0111;
            7'b1000: mm[3:0] = 4'b1000;
            7'b1001: mm[3:0] = 4'b1001;
            7'b1010: mm[3:0] = 4'b1010;
            7'b1011: mm[3:0] = 4'b1011;
            7'b1100: mm[3:0] = 4'b1100;
            7'b1101: mm[3:0] = 4'b1101;
            7'b1110: mm[3:0] = 4'b1110;
            7'b1111: mm[3:0] = 4'b1111;
        endcase

        case (seconds_tens)
            4'b0: ss[7:4] = 4'b0000;
            4'b1: ss[7:4] = 4'b0001;
            4'b10: ss[7:4] = 4'b0010;
            4'b11: ss[7:4] = 4'b0011;
            4'b100: ss[7:4] = 4'b0100;
            4'b101: ss[7:4] = 4'b0101;
        endcase

        case (seconds_ones)
            7'b0: ss[3:0] = 4'b0000;
            7'b1: ss[3:0] = 4'b0001;
            7'b10: ss[3:0] = 4'b0010;
            7'b11: ss[3:0] = 4'b0011;
            7'b100: ss[3:0] = 4'b0100;
            7'b101: ss[3:0] = 4'b0101;
            7'b110: ss[3:0] = 4'b0110;
            7'b111: ss[3:0] = 4'b0111;
            7'b1000: ss[3:0] = 4'b1000;
            7'b1001: ss[3:0] = 4'b1001;
            7'b1010: ss[3:0] = 4'b1010;
            7'b1011: ss[3:0] = 4'b1011;
            7'b1100: ss[3:0] = 4'b1100;
            7'b1101: ss[3:0] = 4'b1101;
            7'b1110: ss[3:0] = 4'b1110;
            7'b1111: ss[3:0] = 4'b1111;
        endcase
    end
    
endmodule
