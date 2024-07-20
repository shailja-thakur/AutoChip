module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal counters for seconds, minutes, and hours
    reg [3:0] sec_ones, sec_tens;
    reg [3:0] min_ones, min_tens;
    reg [3:0] hour_ones, hour_tens;

    // Reset condition: 12:00 AM
    always @(posedge clk) begin
        if (reset) begin
            sec_ones <= 4'b0000;
            sec_tens <= 4'b0000;
            min_ones <= 4'b0000;
            min_tens <= 4'b0000;
            hour_ones <= 4'b0010; // 2
            hour_tens <= 4'b0001; // 1
            pm <= 0; // Am
        end else if (ena) begin
            // Increment seconds
            if (sec_ones == 4'b1001) begin
                sec_ones <= 4'b0000;
                if (sec_tens == 4'b0101) begin
                    sec_tens <= 4'b0000;
                    
                    // Increment minutes
                    if (min_ones == 4'b1001) begin
                        min_ones <= 4'b0000;
                        if (min_tens == 4'b0101) begin
                            min_tens <= 4'b0000;
                            
                            // Increment hours
                            if (hour_ones == 4'b1001) begin
                                hour_ones <= 4'b0000;
                                if (hour_tens == 4'b0001) begin
                                    hour_tens <= 4'b0000;
                                    pm <= ~pm; // Flip am/pm
                                end else if (hour_tens == 4'b0000 && hour_ones == 4'b1001) begin
                                    hour_ones <= 4'b0001; // 1
                                    hour_tens <= 4'b0001; // 1
                                end else begin
                                    hour_tens <= hour_tens + 4'b0001;
                                end
                            end else if (hour_ones == 4'b0010 && hour_tens == 4'b0001) begin
                                hour_ones <= 4'b0001; // 1
                                hour_tens <= 4'b0000; // 0
                                pm <= ~pm; // Toggle am/pm
                            end else begin
                                hour_ones <= hour_ones + 4'b0001;
                            end
                        end else begin
                            min_tens <= min_tens + 4'b0001;
                        end
                    end else begin
                        min_ones <= min_ones + 4'b0001;
                    end
                end else begin
                    sec_tens <= sec_tens + 4'b0001;
                end
            end else begin
                sec_ones <= sec_ones + 4'b0001;
            end
        end
    end

    // Assign the BCD values to the output
    assign ss = {sec_tens, sec_ones};
    assign mm = {min_tens, min_ones};
    assign hh = {hour_tens, hour_ones};

endmodule
