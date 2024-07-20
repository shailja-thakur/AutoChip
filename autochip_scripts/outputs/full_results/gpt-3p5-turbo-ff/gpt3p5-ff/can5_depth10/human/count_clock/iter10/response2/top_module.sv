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
            counter_hh <= 8'b00010010; // 12:00 AM in BCD
            counter_mm <= 8'b00000000;
            counter_ss <= 8'b00000000;
            pm <= 1'b0;
        end else begin
            if (ena) begin
                counter_ss <= counter_ss + 1;
                if (counter_ss == 8'b01101000) begin // 59 in BCD
                    counter_ss <= 8'b00000000;
                    counter_mm <= counter_mm + 1;
                    if (counter_mm == 8'b01111000) begin // 59 in BCD
                        counter_mm <= 8'b00000000;
                        counter_hh <= counter_hh + 1;
                        if (counter_hh[7:4] == 4'b0001) begin // 12 in BCD (AM)
                            counter_hh[7:4] <= 4'b0000; // 1 in BCD
                            if (counter_hh[3:0] == 4'b0001) begin // 10 in BCD
                                counter_hh[3:0] <= 4'b0000; // 0 in BCD
                                pm <= ~pm;
                            end else begin
                                counter_hh[3:0] <= counter_hh[3:0] + 1;
                            end
                        end
                        else if (counter_hh[7:4] == 4'b1100) begin // 12 in BCD (PM)
                            counter_hh[7:4] <= 4'b0000; // 1 in BCD
                            if (counter_hh[3:0] == 4'b0001) begin // 10 in BCD
                                counter_hh[3:0] <= 4'b0000; // 0 in BCD
                                pm <= ~pm;
                            end else begin
                                counter_hh[3:0] <= counter_hh[3:0] + 1;
                            end
                        end
                        else begin
                            counter_hh <= counter_hh + 1;
                        end
                    end
                end
            end
        end
    end
    
    assign hh = counter_hh;
    assign mm = counter_mm;
    assign ss = counter_ss;
    
endmodule
