module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Local counters
    reg [3:0] sec_ones;
    reg [3:0] sec_tens;
    reg [3:0] min_ones;
    reg [3:0] min_tens;
    reg [3:0] hour_ones;
    reg [3:0] hour_tens;

    // Initial state on reset or power up
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 0;
            sec_ones <= 4'h0;
            sec_tens <= 4'h0;
            min_ones <= 4'h0;
            min_tens <= 4'h0;
            hour_ones <= 4'h2;
            hour_tens <= 4'h1;
        end
        else if (ena) begin
            // Increment seconds
            if (sec_ones == 4'h9) begin
                sec_ones <= 4'h0;
                if (sec_tens == 4'h5) begin
                    sec_tens <= 4'h0;
                    
                    // Increment minutes
                    if (min_ones == 4'h9) begin
                        min_ones <= 4'h0;
                        if (min_tens == 4'h5) begin
                            min_tens <= 4'h0;
                            
                            // Increment hours
                            if (hour_ones == 4'h9 || (hour_tens == 4'h1 && hour_ones == 4'h2)) begin
                                hour_ones <= 4'h0;
                                if (hour_tens == 4'h1 && hour_ones == 4'h2) begin
                                    hour_tens <= 4'h0;
                                end else begin
                                    hour_tens <= hour_tens + 4'h1;
                                end
                                if (hh == 8'h11) begin
                                    hh <= 8'h12;
                                    pm <= ~pm; // Toggle AM/PM
                                end
                                else if (hh == 8'h12) begin
                                    hh <= 8'h1;
                                end
                                else begin
                                    hh <= hh + 8'h1;
                                end
                            end
                            else begin
                                hour_ones <= hour_ones + 4'h1;
                            end
                        end else begin
                            min_tens <= min_tens + 4'h1;
                        end
                    end else begin
                        min_ones <= min_ones + 4'h1;
                    end
                end else begin
                    sec_tens <= sec_tens + 4'h1;
                end
            end else begin
                sec_ones <= sec_ones + 4'h1;
            end

            // Update output registers
            ss <= {sec_tens, sec_ones};
            mm <= {min_tens, min_ones};
            hh <= {hour_tens, hour_ones};
        end
    end

endmodule
