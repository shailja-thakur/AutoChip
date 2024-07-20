module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] counters[2:0];
    
    always @(posedge clk) begin
        if (reset) begin
            counters[2] <= 4'd1;
            counters[1] <= 4'd2;
            counters[0] <= 4'd0;
            
            hh <= 8'd1;
            mm <= 8'd2;
            ss <= 8'd0;
            
            pm <= 1'b0;
        end
        else if (ena) begin
            counters[2] <= counters[2] + 1;
            
            if (counters[2] == 2'd1) begin
                counters[1] <= counters[1] + 1;
                
                if (counters[1] == 4'd13) begin
                    counters[1] <= 4'd1;
                    counters[0] <= counters[0] + 1;
                    
                    if (counters[0] == 4'd10) begin
                        counters[0] <= 4'd0;
                        pm <= ~pm;
                    end
                end
            end
            
            if (counters[2] == 2'd3) begin
                counters[2] <= 4'd0;
                ss <= ss + 1;
                
                if (ss == 8'd60) begin
                    ss <= 8'd0;
                    mm <= mm + 1;
                    
                    if (mm == 8'd60) begin
                        mm <= 8'd0;
                        hh <= hh + 1;
                        
                        if (hh == 8'd13) begin
                            hh <= 8'd1;
                        end
                    end
                end
            end
        end
    end
endmodule
