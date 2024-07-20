module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal signals for BCD digits subtraction and reset flag
    reg [3:0] sec_ones, sec_tens, min_ones, min_tens, hour_ones, hour_tens;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset the entire clock to 12:00 AM
            sec_ones <= 4'd0;
            sec_tens <= 4'd0;
            min_ones <= 4'd0;
            min_tens <= 4'd0;
            hour_ones <= 4'd2;
            hour_tens <= 4'd1;
            pm <= 1'b0;
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
                            if (hour_ones == 4'd9 || (hour_tens == 4'd1 && hour_ones == 4'd2)) begin
                                hour_ones <= 4'd0;
                                if (hour_tens == 4'd1 && hour_ones == 4'd2) begin
                                    hour_tens <= 4'd0;
                                end
                                else begin
                                    hour_tens <= hour_tens + 1;
                                end
                                
                                pm <= ~pm; // Toggle AM/PM
                            end
                            else if (hour_ones == 4'd9) begin // Special case for 12
                                hour_ones <= 4'd1;
                            end
                            else begin
                                hour_ones <= hour_ones + 1;
                            end
                        end
                        else begin
                            min_tens <= min_tens + 1;
                        end
                    end
                    else begin
                        min_ones <= min_ones + 1;
                    end
                end
                else begin
                    sec_tens <= sec_tens + 1;
                end
            end
            else begin
                sec_ones <= sec_ones + 1;
            end
        end

        // Assign the BCD values to the output ports
        ss <= {sec_tens, sec_ones};
        mm <= {min_tens, min_ones};
        hh <= {hour_tens, hour_ones};
    end
endmodule
