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
    reg [1:0] am_pm;
    
    always @(posedge clk) begin
        if (reset) begin
            counter_hh <= 8'b00010010; // 12 in BCD
            counter_mm <= 8'b00000000; // 0 in BCD
            counter_ss <= 8'b00000000; // 0 in BCD
            am_pm <= 2'b00; // AM
        end else if (ena) begin
            counter_ss <= counter_ss + 1;
            if (counter_ss == 8'b01101000) begin // 59 in BCD
                counter_ss <= 8'b00000000; // 0 in BCD
                counter_mm <= counter_mm + 1;
                if (counter_mm == 8'b01111000) begin // 59 in BCD
                    counter_mm <= 8'b00000000; // 0 in BCD
                    counter_hh <= counter_hh + 1;
                    if (counter_hh == 8'b00110010) begin // 12 in BCD (PM)
                        if (am_pm == 2'b00) begin // AM
                            counter_hh <= 8'b00000001; // 1 in BCD
                            am_pm <= 2'b01; // PM
                        else if (am_pm == 2'b01) begin // PM
                            counter_hh <= 8'b00010000; // 10 in BCD
                            am_pm <= 2'b00; // AM
                        end
                    else if (counter_hh > 8'b00110101) begin // 13 - 23 in BCD (PM)
                        if (am_pm == 2'b00) begin // AM
                            counter_hh <= 8'b00000001; // 1 in BCD
                            am_pm <= 2'b01; // PM
                        end
                        else if (am_pm == 2'b01) begin // PM
                            counter_hh <= 8'b00010010; // 12 in BCD
                            am_pm <= 2'b00; // AM
                        end
                    end
                end
            end
        end
    end
    
    assign pm = (am_pm == 2'b01);
    assign hh = counter_hh;
    assign mm = counter_mm;
    assign ss = counter_ss;
    
endmodule
