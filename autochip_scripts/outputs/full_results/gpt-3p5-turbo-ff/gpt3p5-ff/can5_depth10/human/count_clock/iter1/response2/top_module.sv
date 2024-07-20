module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [5:0] counter_hh;
    reg [5:0] counter_mm;
    reg [5:0] counter_ss;
    
    always @(posedge clk) begin
        if (reset) begin
            counter_hh <= 6'b000000; // 12 in BCD
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
                        if (counter_hh == 6'b001100 || counter_hh == 6'b010000) begin // 12 in BCD (AM) or 12 in BCD (PM)
                            counter_hh <= 6'b000001; // 01 in BCD
                            pm <= ~pm;
                        end else if (counter_hh == 6'b010001) begin // 09 in BCD
                            counter_hh <= 6'b001000; // 10 in BCD
                        end else if (counter_hh == 6'b100001) begin // 19 in BCD
                            counter_hh <= 6'b001001; // 20 in BCD
                        end else if (counter_hh == 6'b101100) begin // 21 in BCD
                            counter_hh <= 6'b001010; // 22 in BCD
                        end
                    end
                end
            end
        end
    end
    
    assign hh = {counter_hh[5:4], counter_hh[3:0]};
    assign mm = {counter_mm[5:4], counter_mm[3:0]};
    assign ss = {counter_ss[5:4], counter_ss[3:0]};
    
endmodule
