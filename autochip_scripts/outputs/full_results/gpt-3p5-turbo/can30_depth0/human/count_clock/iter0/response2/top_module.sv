module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [7:0] count_hh;
    reg [7:0] count_mm;
    reg [7:0] count_ss;

    always @(posedge clk) begin
        if (reset)
            begin
                count_hh <= 8'd12;
                count_mm <= 8'd0;
                count_ss <= 8'd0;
                pm <= 1'b0;
            end
        else if (ena)
            begin
                count_ss <= count_ss + 8'd1;
                
                if (count_ss >= 8'd60)
                    begin
                        count_ss <= 8'd0;
                        count_mm <= count_mm + 8'd1;
                        
                        if (count_mm >= 8'd60)
                            begin
                                count_mm <= 8'd0;
                                count_hh <= count_hh + 8'd1;
                                
                                if (count_hh >= 8'd12)
                                    begin
                                        count_hh <= 8'd1;
                                        pm <= ~pm;
                                    end
                            end
                    end
            end
    end

    assign hh = {count_hh[7:4], count_hh[3:0]};
    assign mm = {count_mm[7:4], count_mm[3:0]};
    assign ss = {count_ss[7:4], count_ss[3:0]};

endmodule
