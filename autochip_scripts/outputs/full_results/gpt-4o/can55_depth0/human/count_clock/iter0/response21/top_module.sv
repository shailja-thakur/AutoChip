module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal variables for individual BCD digits
    reg [3:0] hh_tens, hh_ones;
    reg [3:0] mm_tens, mm_ones;
    reg [3:0] ss_tens, ss_ones;

    always @(posedge clk) begin
        if (reset) begin
            // Reset clock to 12:00 AM
            hh_tens <= 4'd1;
            hh_ones <= 4'd2;
            mm_tens <= 4'd0;
            mm_ones <= 4'd0;
            ss_tens <= 4'd0;
            ss_ones <= 4'd0;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss_ones == 4'd9) begin
                ss_ones <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;

                    // Increment minutes
                    if (mm_ones == 4'd9) begin
                        mm_ones <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;

                            // Increment hours
                            if (hh_ones == 4'd9) begin
                                hh_ones <= 4'd0;
                                hh_tens <= hh_tens + 4'd1;
                            end else if (hh_ones == 4'd2 && hh_tens == 4'd1) begin
                                hh_ones <= 4'd1;
                                hh_tens <= 4'd0;
                                pm <= ~pm; // Toggle AM/ PM
                            end else begin
                                hh_ones <= hh_ones + 4'd1;
                            end

                            if (hh_ones == 4'd2 && hh_tens == 4'd1) begin
                                hh_tens <= 4'd0;
                                hh_ones <= 4'd1;
                                pm <= ~pm; // Toggle AM/ PM
                            end
                        end else begin
                            mm_tens <= mm_tens + 4'd1;
                        end
                    end else begin
                        mm_ones <= mm_ones + 4'd1;
                    end
                end
                else begin
                    ss_tens <= ss_tens + 4'd1;
                end
            end
            else begin
                ss_ones <= ss_ones + 4'd1;
            end

            // Special handling for the hour '12'
            if (hh_tens == 4'd1 && hh_ones == 4'd2 && mm_tens == 4'd0 && mm_ones == 4'd0 && ss_tens == 4'd0 && ss_ones == 4'd0) begin
                if (ena) begin
                    pm <= ~pm;  // Toggle AM/PM
                end
            end

            // Convert and assign BCD values back to 8-bit outputs
            hh <= {hh_tens, hh_ones};
            mm <= {mm_tens, mm_ones};
            ss <= {ss_tens, ss_ones};
        end
    end
endmodule
