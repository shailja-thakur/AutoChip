module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Declare internal registers for hours, minutes, and seconds
    reg [3:0] sec_ones, sec_tens;
    reg [3:0] min_ones, min_tens;
    reg [3:0] hr_ones, hr_tens;

    // Initialize the clock to 12:00 AM
    initial begin
        pm = 0;  // AM
        hr_tens = 1;
        hr_ones = 2;
        min_tens = 0;
        min_ones = 0;
        sec_tens = 0;
        sec_ones = 0;
    end

    // Combining the BCD digits into the 8-bit outputs
    always @(*) begin
        hh = {hr_tens, hr_ones};
        mm = {min_tens, min_ones};
        ss = {sec_tens, sec_ones};
    end

    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;  // AM
            hr_tens <= 1;
            hr_ones <= 2;
            min_tens <= 0;
            min_ones <= 0;
            sec_tens <= 0;
            sec_ones <= 0;
        end else if (ena) begin
            // Increment the clock
            if (sec_ones == 9) begin
                sec_ones <= 0;
                if (sec_tens == 5) begin
                    sec_tens <= 0;
                    if (min_ones == 9) begin
                        min_ones <= 0;
                        if (min_tens == 5) begin
                            min_tens <= 0;
                            if (hr_ones == 9 || (hr_tens == 1 && hr_ones == 2)) begin
                                hr_ones <= 1;
                                hr_tens <= 0;
                                pm <= ~pm;
                            end else if (hr_ones == 9) begin
                                hr_ones <= 0;
                                hr_tens <= 1;
                            end else if (hr_ones == 2 && hr_tens == 1) begin
                                hr_ones <= 0;
                                hr_tens <= 1;
                            end else begin
                                hr_ones <= hr_ones + 1;
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
endmodule
