module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [7:0] count;
    reg [1:0] hour_tens;
    reg [3:0] hour_ones;
    reg [4:0] min_tens;
    reg [3:0] min_ones;
    reg [4:0] sec_tens;
    reg [3:0] sec_ones;
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            hour_tens <= 0;
            hour_ones <= 0;
            min_tens <= 0;
            min_ones <= 0;
            sec_tens <= 0;
            sec_ones <= 0;
            pm <= 0;
        end else if (ena) begin
            count <= count + 1;
            
            if (count == 999) begin
                count <= 0;
                
                if (sec_ones == 9) begin
                    sec_ones <= 0;
                    
                    if (sec_tens == 5) begin
                        sec_tens <= 0;
                        
                        if (min_ones == 9) begin
                            min_ones <= 0;
                            
                            if (min_tens == 5) begin
                                min_tens <= 0;
                                
                                if (hour_ones == 9) begin
                                    hour_ones <= 0;
                                    
                                    if (hour_tens == 1) begin
                                        hour_tens <= 0;
                                        
                                        if (pm) begin
                                            pm <= 0;
                                        end else begin
                                            pm <= 1;
                                        end
                                    end else begin
                                        hour_tens <= hour_tens + 1;
                                    end
                                end else begin
                                    hour_ones <= hour_ones + 1;
                                end
                            end else begin
                                min_tens <= min_tens + 1;
                            end
                        end else begin
                            min_ones <= min_ones + 1;
                        end
                    end else begin
                        sec_tens <= sec_tens + 1;
                    end
                end else begin
                    sec_ones <= sec_ones + 1;
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00000000;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
        end else if (ena) begin
            if (count == 0) begin
                hh <= {4'b0000, hour_tens, hour_ones};
                mm <= {4'b0000, min_tens, min_ones};
                ss <= {4'b0000, sec_tens, sec_ones};
            end
        end
    end
    
endmodule
