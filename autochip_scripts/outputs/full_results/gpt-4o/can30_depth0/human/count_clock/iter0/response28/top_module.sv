module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Separate BCD digits
    reg [3:0] hh_tens, hh_units;
    reg [3:0] mm_tens, mm_units;
    reg [3:0] ss_tens, ss_units;

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            hh_tens <= 1;
            hh_units <= 2;
            mm_tens <= 0;
            mm_units <= 0;
            ss_tens <= 0;
            ss_units <= 0;
            pm <= 0; // AM
        end else if (ena) begin
            // Increment Second Units
            if (ss_units == 9) begin
                ss_units <= 0;
                // Increment Second Tens
                if (ss_tens == 5) begin
                    ss_tens <= 0;
                    // Increment Minute Units
                    if (mm_units == 9) begin
                        mm_units <= 0;
                        // Increment Minute Tens
                        if (mm_tens == 5) begin
                            mm_tens <= 0;
                            // Increment Hour Units
                            if (hh_units == 9 || (hh_tens == 1 && hh_units == 2)) begin
                                // Handling special case of 12 AM/PM to 01 AM/PM
                                if (hh_tens == 1 && hh_units == 2) begin
                                    hh_tens <= 0;
                                    hh_units <= 1;
                                    pm <= ~pm; // Toggle AM/PM
                                end else begin
                                    hh_tens <= hh_tens + 1;
                                    hh_units <= 0;
                                end
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
        
        // Update the outputs
        hh <= {hh_tens, hh_units};
        mm <= {mm_tens, mm_units};
        ss <= {ss_tens, ss_units};
    end
endmodule
