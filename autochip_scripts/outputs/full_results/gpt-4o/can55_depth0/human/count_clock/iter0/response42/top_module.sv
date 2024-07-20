module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [3:0] sec_ones, sec_tens;
    reg [3:0] min_ones, min_tens;
    reg [3:0] hour_ones, hour_tens;

    // Generate BCD for 12 (for hour comparison and reset)
    wire [7:0] bcd_12 = 8'b00010010;
    
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'b00000000;
            mm <= 8'b00000000;
            hh <= 8'b00010010;
            pm <= 0;
        end else if (ena) begin
            // Increment seconds
            if (sec_ones == 4'd9) begin
                sec_ones <= 4'd0;
                if (sec_tens == 4'd5) begin
                    sec_tens <= 4'd0;
                    
                    // Increment minutes
                    if (min_ones == 4'd9) begin
                        min_ones <= 4'd0;
                        if (min_tens == 4'd5) begin
                            min_tens <= 4'd0;
                            
                            // Increment hours
                            if (hour_ones == 4'd9) begin
                                hour_ones <= 4'd0;
                                hour_tens <= hour_tens + 1;
                            end else if (hour_ones == 4'd0 && hour_tens == 4'd1) begin
                                hour_ones <= 4'd1;
                            end else if (hour_ones == 4'd2 && hour_tens == 4'd0) begin
                                hour_ones <= 4'd3;
                                hour_tens <= hour_tens - 1;
                            end else begin
                                hour_ones <= hour_ones + 1;
                            end

                            if (hour_ones == 4'd1 && hour_tens == 4'd1 && ena) begin
                                hour_ones <= 4'd2; 
                                hour_tens <= 4'd0;
                                pm <= ~pm;
                            end else if (hour_ones == 4'd2 && hour_tens == 4'd1) begin
                                hour_ones <= 4'd1; 
                                hour_tens <= 4'd0;
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
            
            // Update the BCD outputs
            ss <= {sec_tens, sec_ones};
            mm <= {min_tens, min_ones};
            hh <= {hour_tens, hour_ones};
        end
    end

endmodule
