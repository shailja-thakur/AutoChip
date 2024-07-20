module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal registers for easier handling
    reg [3:0] hh_tens;
    reg [3:0] hh_units;
    reg [3:0] mm_tens;
    reg [3:0] mm_units;
    reg [3:0] ss_tens;
    reg [3:0] ss_units;

    always @(posedge clk) begin
        if (reset) begin
            hh_tens <= 1;
            hh_units <= 2;
            mm_tens <= 0;
            mm_units <= 0;
            ss_tens <= 0;
            ss_units <= 0;
            pm <= 0;
        end else if (ena) begin
            // Increment seconds
            if (ss_units == 9) begin
                ss_units <= 0;
                if (ss_tens == 5) begin
                    ss_tens <= 0;
                    // Increment minutes
                    if (mm_units == 9) begin
                        mm_units <= 0;
                        if (mm_tens == 5) begin
                            mm_tens <= 0;
                            // Increment hours
                            if (hh_units == 9 || (hh_tens == 1 && hh_units == 2)) begin
                                hh_units <= (hh_units == 9) ? 0 : hh_units + 1;
                                if (hh_units == 9) begin
                                    if (hh_tens == 1) begin
                                        hh_tens <= 0;
                                    end else if (hh_tens == 0 && hh_units == 9) begin
                                        hh_tens <= 1;
                                        // Toggle AM/PM
                                        pm <= ~pm;
                                    end else begin
                                        hh_units <= 1;
                                    end
                                end else begin
                                    hh_units <= 1;
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
        
        // Output concatenation
        ss <= {ss_tens, ss_units};
        mm <= {mm_tens, mm_units};
        hh <= {hh_tens, hh_units};
    end
endmodule
