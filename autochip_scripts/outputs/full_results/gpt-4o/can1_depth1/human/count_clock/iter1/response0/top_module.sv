module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal temporary registers to hold values for comparison and incrementation
    reg [3:0] sec_tens, sec_ones;
    reg [3:0] min_tens, min_ones;
    reg [3:0] hour_tens, hour_ones;

    // Initialize values on reset
    always @(posedge clk) begin
        if (reset) begin
            sec_tens <= 4'd0; sec_ones <= 4'd0;
            min_tens <= 4'd0; min_ones <= 4'd0;
            hour_tens <= 4'd1; hour_ones <= 4'd2; // 12
            pm <= 0; // AM
        end
        else if (ena) begin
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
                            if (hour_ones == 4'd9 && hour_tens == 4'd1) begin
                                hour_ones <= 4'd1; hour_tens <= 4'd0; // 12 -> 1
                                pm <= ~pm;
                            end
                            else if (hour_ones == 4'd2 && hour_tens == 4'd1) begin
                                hour_ones <= 4'd1; hour_tens <= 4'd0;
                                pm <= ~pm;  // PM/AM toggle at 12 -> 1
                            end
                            else if (hour_ones == 4'd9) begin
                                hour_ones <= 4'd0;
                                hour_tens <= hour_tens + 4'd1;
                            end
                            else begin
                                hour_ones <= hour_ones + 4'd1;
                            end
                        end
                        else begin
                            min_tens <= min_tens + 4'd1;
                        end
                    end
                    else begin
                        min_ones <= min_ones + 4'd1;
                    end
                end
                else begin
                    sec_tens <= sec_tens + 4'd1;
                end
            end
            else begin
                sec_ones <= sec_ones + 4'd1;
            end
        end
        
        // Combine the tens and ones for outputs
        hh <= {hour_tens, hour_ones};
        mm <= {min_tens, min_ones};
        ss <= {sec_tens, sec_ones};
    end
endmodule
