module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk or posedge reset) begin
        if (reset)
            begin
                pm <= 0;
                hh <= 8'b0001; // 12 in binary-coded decimal
                mm <= 8'b0000;
                ss <= 8'b0000;
            end
        else if (ena)
            begin
                if (hh == 8'b0001 && mm == 8'b1010 && ss == 8'b1010) // 11:59:59
                    begin
                        hh <= 8'b0001;
                        mm <= 8'b0000;
                        ss <= 8'b0000;
                        pm <= ~pm;
                    end
                else if (ss == 8'b1010) // 9 seconds (59)
                    begin
                        sb <= 8'b0000;
                        mm <= mm + 1;
                    end
                else if (mm == 8'b1010) // 9 minutes (59)
                    begin
                        ss <= ss + 1;
                        mm <= 8'b0000;
                    end
                else if (hh == 8'b0001 && mm == 8'b0101) // 9:59
                    begin
                        ss <= ss + 1;
                        mm <= 8'b0000;
                        hh <= hh + 1;
                    end
                else if (hh == 8'b0001) // 1 to 9 hours (01-09)
                    begin
                        if (ss == 8'b1010) // 9 seconds (59)
                            begin
                                ss <= 8'b0000;
                                mm <= mm + 1;
                                hh <= hh + 1;
                            end
                        else
                            ss <= ss + 1;
                    end
                else if (mm == 8'b1010) // 9 minutes (59)
                    begin
                        ss <= ss + 1;
                        mm <= 8'b0000;
                        hh <= hh + 1;
                    end
                else if (hh == 8'b1010) // 9 hours (09)
                    begin
                        ss <= ss + 1;
                        mm <= mm + 1;
                        hh <= 8'b0000;
                        pm <= ~pm;
                    end
                else
                    ss <= ss + 1;
            end
    end

endmodule
