module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Declare variables for the BCD digits
    reg [3:0] hh_tens;
    reg [3:0] hh_ones;
    reg [3:0] mm_tens;
    reg [3:0] mm_ones;
    reg [3:0] ss_tens;
    reg [3:0] ss_ones;

    always @(posedge clk) begin
        // Check if reset is asserted
        if (reset) begin
            // Reset the clock to 12:00 AM
            hh_tens <= 0;
            hh_ones <= 1;
            mm_tens <= 0;
            mm_ones <= 0;
            ss_tens <= 0;
            ss_ones <= 0;
        end else if (ena) begin
            // Increment the seconds counter
            ss_ones <= ss_ones + 1;

            if (ss_ones >= 10) begin
                // Carry over to the tens digit if necessary
                ss_ones <= 0;
                ss_tens <= ss_tens + 1;

                // Handle rollover for seconds
                if (ss_tens >= 6) begin
                    ss_tens <= 0;
                    mm_ones <= mm_ones + 1;

                    // Handle rollover for minutes
                    if (mm_ones >= 10) begin
                        mm_ones <= 0;
                        mm_tens <= mm_tens + 1;

                        // Handle rollover for hours
                        if (mm_tens >= 6) begin
                            mm_tens <= 0;
                            hh_ones <= hh_ones + 1;
                            
                            // Handle rollover for tens digit of hours
                            if (hh_ones >= 10) begin
                                hh_ones <= 0;
                                hh_tens <= hh_tens + 1;

                                // Handle special case for 12:00 PM
                                if (hh_tens == 1 && hh_ones == 2 && mm_tens == 0 && mm_ones == 0 && ss_tens == 0 && ss_ones == 0) begin
                                    pm <= 1;
                                end
                            end
                        end
                    end
                end
            end
        end
        
        // Update the output signals with the BCD digits
        hh <= {hh_tens, hh_ones};
        mm <= {mm_tens, mm_ones};
        ss <= {ss_tens, ss_ones};
    end
endmodule
