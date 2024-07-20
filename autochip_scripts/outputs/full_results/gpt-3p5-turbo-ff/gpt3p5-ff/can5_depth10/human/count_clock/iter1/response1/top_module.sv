module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [9:0] counter_hh;
    reg [9:0] counter_mm;
    reg [9:0] counter_ss;
    
    always @(posedge clk) begin
        if (reset) begin
            counter_hh <= 10'b0001001000; // 12:00 AM in BCD
            counter_mm <= 10'b0000000000;
            counter_ss <= 10'b0000000000;
            pm <= 1'b0;
        end else if (ena) begin
            if (counter_ss == 10'b0110100100) begin // 59 in BCD
                counter_ss <= 10'b0000000000;
                counter_mm <= counter_mm + 10'b0000000001;
                if (counter_mm == 10'b0110100100) begin // 59 in BCD
                    counter_mm <= 10'b0000000000;
                    counter_hh <= counter_hh + 10'b0000000001;
                    if (counter_hh == 10'b0001001000 || counter_hh == 10'b0011001000) begin // 12 in BCD (AM) or 12 in BCD (PM)
                        counter_hh <= 10'b0001000111; // 01 in BCD
                        pm <= ~pm;
                    end else if (counter_hh == 10'b0101001000) begin // 09 in BCD
                        counter_hh <= 10'b0001001000; // 10 in BCD
                    end else if (counter_hh == 10'b1001001000) begin // 19 in BCD
                        counter_hh <= 10'b0001000111; // 20 in BCD
                    end else if (counter_hh == 10'b1011001000) begin // 21 in BCD
                        counter_hh <= 10'b0001001000; // 22 in BCD
                    end
                end
            end else begin
                counter_ss <= counter_ss + 10'b0000000001;
            end
        end
    end
    
    assign hh = counter_hh[7:0];
    assign mm = counter_mm[7:0];
    assign ss = counter_ss[7:0];
    
endmodule
