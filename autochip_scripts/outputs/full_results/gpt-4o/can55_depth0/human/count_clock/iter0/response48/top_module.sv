module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal signals for individual BCD digits
    reg [3:0] hh_tens, hh_units;
    reg [3:0] mm_tens, mm_units;
    reg [3:0] ss_tens, ss_units;
    
    // Always block to handle clock updates
    always @(posedge clk) begin
        if (reset) begin
            // Reset time to 12:00:00 AM
            hh_tens <= 4'd1;
            hh_units <= 4'd2;
            mm_tens <= 4'd0;
            mm_units <= 4'd0;
            ss_tens <= 4'd0;
            ss_units <= 4'd0;
            pm <= 1'b0; // AM
        end
        else if (ena) begin
            // Increment the seconds
            if (ss_units == 4'd9) begin
                ss_units <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;
                    // Increment the minutes
                    if (mm_units == 4'd9) begin
                        mm_units <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;
                            // Increment the hours
                            if (hh_units == 4'd9) begin
                                hh_units <= 4'd0;
                                if (hh_tens == 4'd1) begin
                                    hh_tens <= 4'd0;
                                    hh_units <= 4'd1;
                                    pm <= ~pm; // Toggle AM/PM
                                end
                                else begin
                                    hh_units <= hh_units + 4'd1;
                                end
                            end
                            else if (hh_units == 4'd2 && hh_tens == 4'd1) begin
                                hh_units <= 4'd0;
                                hh_tens <= 4'd1;
                                pm <= ~pm; // Toggle AM/PM
                            end
                            else begin
                                hh_units <= hh_units + 4'd1;
                            end
                        end
                        else begin
                            mm_tens <= mm_tens + 4'd1;
                        end
                    end
                    else begin
                        mm_units <= mm_units + 4'd1;
                    end
                end
                else begin
                    ss_tens <= ss_tens + 4'd1;
                end
            end
            else begin
                ss_units <= ss_units + 4'd1;
            end
        end
    end

    // Assign BCD digits to the output ports
    always @(*) begin
        hh = {hh_tens, hh_units};
        mm = {mm_tens, mm_units};
        ss = {ss_tens, ss_units};
    end

endmodule
