module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [3:0] counter_hh;
    reg [5:0] counter_mm;
    reg [5:0] counter_ss;
    
    always @(posedge clk) begin
        if (reset) begin
            counter_hh <= 4'b0001; // 12 in BCD
            counter_mm <= 6'b000000;
            counter_ss <= 6'b000000;
            pm <= 1'b0;
        end else begin
            if (ena) begin
                counter_ss <= counter_ss + 1;
                if (counter_ss == 6'b011010) begin // 59 in BCD
                    counter_ss <= 6'b000000;
                    counter_mm <= counter_mm + 1;
                    if (counter_mm == 6'b011010) begin // 59 in BCD
                        counter_mm <= 6'b000000;
                        counter_hh <= counter_hh + 1;
                        if (counter_hh == 4'b0001 || counter_hh == 4'b0011) begin // 12 in BCD (AM) or 12 in BCD (PM)
                            counter_hh <= 4'b0001; // 01 in BCD
                            pm <= ~pm;
                        end else if (counter_hh == 4'b0101) begin // 09 in BCD
                            counter_hh <= 4'b0001; // 10 in BCD
                        end else if (counter_hh == 4'b1001) begin // 19 in BCD
                            counter_hh <= 4'b0001; // 20 in BCD
                        end else if (counter_hh == 4'b1011) begin // 21 in BCD
                            counter_hh <= 4'b0001; // 22 in BCD
                        end
                    end
                end
            end
        end
    end
    
    assign hh = {counter_hh[3], counter_hh[2], counter_hh[1], counter_hh[0]};
    assign mm = {counter_mm[5], counter_mm[4], counter_mm[3], counter_mm[2], counter_mm[1], counter_mm[0]};
    assign ss = {counter_ss[5], counter_ss[4], counter_ss[3], counter_ss[2], counter_ss[1], counter_ss[0]};
    
endmodule
