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
                        if (counter_hh == 8'b00010011 || counter_hh == 8'b00110010) begin // 13 in BCD (AM) or 12 in BCD (PM)
                            counter_hh <= 8'b00000001; // 1 in BCD
                            pm <= ~pm;
                        end else if (counter_hh == 8'b00001001) begin // 9 in BCD
                            counter_hh <= 8'b00010000; // 10 in BCD
                        end else if (counter_hh == 8'b00101001) begin // 9 in BCD
                            counter_hh <= 8'b00000001; // 1 in BCD
                        end else if (counter_hh == 8'b00010010) begin // 12 in BCD (PM)
                            counter_hh <= 8'b00010000; // 10 in BCD
                        end else if (counter_hh == 8'b00010011) begin // 13 in BCD (PM)
                            counter_hh <= 8'b00010000; // 10 in BCD
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
