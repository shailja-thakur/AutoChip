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
            counter_hh <= 6'b000100; // 12 in BCD
            counter_mm <= 6'b000000; // 0 in BCD
            counter_ss <= 6'b000000; // 0 in BCD
            pm <= 1'b0;
        end else begin
            if (ena) begin
                counter_ss <= counter_ss + 1;
                if (counter_ss == 6'b011010) begin // 59 in BCD
                    counter_ss <= 6'b000000; // 0 in BCD
                    counter_mm <= counter_mm + 1;
                    if (counter_mm == 6'b011110) begin // 59 in BCD
                        counter_mm <= 6'b000000; // 0 in BCD
                        counter_hh <= counter_hh + 1;
                        if (counter_hh == 6'b000011 || counter_hh == 6'b001100) begin // 12 in BCD (AM) or 12 in BCD (PM)
                            counter_hh <= 6'b000001; // 1 in BCD
                            pm <= ~pm;
                        end else if (counter_hh == 6'b001010) begin // 10 in BCD
                            counter_hh <= 6'b000100; // 10 in BCD
                        end else if (counter_hh == 6'b000100) begin // 9 in BCD
                            counter_hh <= 6'b000101; // 10 in BCD
                        end else if (counter_hh == 6'b001011) begin // 11 in BCD
                            counter_hh <= 6'b000011; // 12 in BCD
                            pm <= 1'b1;
                        end
                    end
                end
            end
        end
    end
    
    assign hh = {pm, counter_hh};
    assign mm = {counter_mm[3:0], counter_mm[9:6]};
    assign ss = {counter_ss[3:0], counter_ss[9:6]};
    
endmodule
