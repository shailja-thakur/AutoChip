module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal signals to hold the BCD values
    reg [3:0] hh_ones, hh_tens;
    reg [3:0] mm_ones, mm_tens;
    reg [3:0] ss_ones, ss_tens;
    
    // Convert BCD to unified 8-bit values for hours, minutes, and seconds
    assign hh = {hh_tens, hh_ones};
    assign mm = {mm_tens, mm_ones};
    assign ss = {ss_tens, ss_ones};

    // Always block for the clocking logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            hh_ones <= 4'd2;
            hh_tens <= 4'd1;
            mm_ones <= 4'd0;
            mm_tens <= 4'd0;
            ss_ones <= 4'd0;
            ss_tens <= 4'd0;
            pm <= 0; // AM
        end else if (ena) begin
            // Increment the seconds
            if (ss_ones == 4'd9) begin
                ss_ones <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;
                    // Increment the minutes
                    if (mm_ones == 4'd9) begin
                        mm_ones <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;
                            // Increment the hours
                            if (hh_ones == 4'd9 || (hh_tens == 4'd1 && hh_ones == 4'd2)) begin
                                hh_ones <= 4'd1;
                                hh_tens <= (hh_tens == 4'd1) ? 4'd0 : 4'd1;
                                pm <= ~pm; // Toggle AM/PM
                            end else begin
                                hh_ones <= hh_ones + 4'd1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 4'd1;
                        end
                    end else begin
                        mm_ones <= mm_ones + 4'd1;
                    end
                end else begin
                    ss_tens <= ss_tens + 4'd1;
                end
            end else begin
                ss_ones <= ss_ones + 4'd1;
            end
        end
    end
endmodule
