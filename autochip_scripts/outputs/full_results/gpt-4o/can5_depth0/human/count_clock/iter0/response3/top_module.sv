module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD digits for hours, minutes, and seconds
    reg [3:0] hh_tens, hh_units, mm_tens, mm_units, ss_tens, ss_units;

    // Initialize the clock
    initial begin
        hh_tens = 1;
        hh_units = 2;
        mm_tens = 0;
        mm_units = 0;
        ss_tens = 0;
        ss_units = 0;
        pm = 0;
    end

    always @(posedge clk) begin
        if (reset) begin
            // Reset the clock to "12:00 AM"
            hh_tens <= 1;
            hh_units <= 2;
            mm_tens <= 0;
            mm_units <= 0;
            ss_tens <= 0;
            ss_units <= 0;
            pm <= 0;
        end else if (ena) begin
            // Increment the seconds units place
            if (ss_units == 9) begin
                ss_units <= 0;

                // Increment the seconds tens place
                if (ss_tens == 5) begin
                    ss_tens <= 0;

                    // Increment the minutes units place
                    if (mm_units == 9) begin
                        mm_units <= 0;

                        // Increment the minutes tens place
                        if (mm_tens == 5) begin
                            mm_tens <= 0;

                            // Increment the hours units place
                            if (hh_units == 9) begin
                                hh_units <= 0;
                                hh_tens <= hh_tens + 1;
                            end else if (hh_units == 2 && hh_tens == 1) begin
                                // Roll over to 1:00 after 12:00
                                hh_units <= 1;
                                hh_tens <= 0;

                                // Toggle AM/PM
                                pm <= ~pm;
                            end else begin
                                hh_units <= hh_units + 1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 1;
                        end
                    end else begin
                        mm_units <= mm_units + 1;
                    end
                end else begin
                    ss_tens <= ss_tens + 1;
                end
            end else begin
                ss_units <= ss_units + 1;
            end
        end

        // Combine the BCD digits into the outputs
        hh <= {hh_tens, hh_units};
        mm <= {mm_tens, mm_units};
        ss <= {ss_tens, ss_units};
    end
endmodule
