module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [7:0] counter_hh;
    reg [7:0] counter_mm;
    reg [7:0] counter_ss;
    
    always @(posedge clk) begin
        if (reset) begin
            counter_hh <= 8'b00010010; // 12 in BCD
            counter_mm <= 8'b00000000; // 0 in BCD
            counter_ss <= 8'b00000000; // 0 in BCD
            pm <= 1'b0;
        end else begin
            if (ena) begin
                counter_ss <= counter_ss + 1;
                if (counter_ss == 8'b01101000) begin // 59 in BCD
                    counter_ss <= 8'b00000000; // 0 in BCD
                    counter_mm <= counter_mm + 1;
                    if (counter_mm == 8'b01111000) begin // 59 in BCD
                        counter_mm <= 8'b00000000; // 0 in BCD
                        counter_hh <= counter_hh + 1;
                        if (counter_hh == 8'b00011010 || counter_hh == 8'b00110010) begin // 12 in BCD (AM) or 12 in BCD (PM)
                            counter_hh <= 8'b00000001; // 1 in BCD
                            pm <= ~pm;
                        end else if (counter_hh == 8'b00101001) begin // 9 in BCD
                            counter_hh <= 8'b00010000; // 10 in BCD
                        end else if (counter_hh == 8'b00001001) begin // 9 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00010010) begin // 12 in BCD (PM)
                            counter_hh <= 8'b00010000; // 10 in BCD
                        end else if (counter_hh == 8'b00010011) begin // 13 in BCD (PM)
                            counter_hh <= 8'b00010000; // 10 in BCD
                        end else if (counter_hh == 8'b00110000) begin // 30 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00110001) begin // 31 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00110010) begin // 32 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00110011) begin // 33 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00110100) begin // 34 in BCD
                            counter_hh <= 8'b00000011; // 3 in BCD
                        end else if (counter_hh == 8'b00110101) begin // 35 in BCD
                            counter_hh <= 8'b00000011; // 3 in BCD
                        end else if (counter_hh == 8'b00110110) begin // 36 in BCD
                            counter_hh <= 8'b00000011; // 3 in BCD
                        end else if (counter_hh == 8'b00110111) begin // 37 in BCD
                            counter_hh <= 8'b00000011; // 3 in BCD
                        end else if (counter_hh == 8'b00111000) begin // 38 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111001) begin // 39 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111010) begin // 40 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111011) begin // 41 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111100) begin // 42 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111101) begin // 43 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111110) begin // 44 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b00111111) begin // 45 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000000) begin // 46 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000001) begin // 47 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000010) begin // 48 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000011) begin // 49 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000100) begin // 50 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000101) begin // 51 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000110) begin // 52 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01000111) begin // 53 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01001000) begin // 54 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01001001) begin // 55 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01001010) begin // 56 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01001011) begin // 57 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01001100) begin // 58 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01001101) begin // 59 in BCD
                            counter_hh <= 8'b00000010; // 2 in BCD
                        end else if (counter_hh == 8'b01100010) begin // 80 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b01110001) begin // 91 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b10000000) begin // 128 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b10010000) begin // 144 in BCD (PM)
                            counter_hh <= 8'b00000001; // 1 in BCD
                            pm <= ~pm;
                        end else if (counter_hh == 8'b10111111) begin // 191 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b11010100) begin // 212 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b11101011) begin // 235 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b11111010) begin // 250 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b11111111) begin // 255 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000000) begin // 256 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000001) begin // 257 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000010) begin // 258 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000011) begin // 259 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000100) begin // 260 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000101) begin // 261 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000110) begin // 262 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00000111) begin // 263 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00001000) begin // 264 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00001001) begin // 265 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end
                    end
                end
            end
        end
    end
    
    assign hh = {pm, counter_hh};
    assign mm = {counter_mm[3:0], counter_mm[7:4]};
    assign ss = {counter_ss[3:0], counter_ss[7:4]};
    
endmodule
