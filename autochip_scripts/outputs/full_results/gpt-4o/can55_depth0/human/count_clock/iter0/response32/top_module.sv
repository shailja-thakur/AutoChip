module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] hh_tens, hh_units, mm_tens, mm_units, ss_tens, ss_units;

    always @(posedge clk) begin
        if (reset) begin
            pm <= 1'b0;
            hh_tens <= 4'd1;
            hh_units <= 4'd2;
            mm_tens <= 4'd0;
            mm_units <= 4'd0;
            ss_tens <= 4'd0;
            ss_units <= 4'd0;
        end else if (ena) begin
            // Increment seconds
            if (ss_units == 4'd9) begin
                ss_units <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;
                    // Increment minutes
                    if (mm_units == 4'd9) begin
                        mm_units <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;
                            // Increment hours
                            if ((hh_units == 4'd9) || ((hh_tens != 4'd0) && (hh_units == 4'd2))) begin
                                hh_units <= 4'd1;
                                hh_tens <= 4'd0;
                                pm <= ~pm; // Toggle AM/PM
                            end else if (hh_units == 4'd2) begin
                                hh_units <= 4'd3;
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

        // Update the BCD outputs
        hh <= {hh_tens, hh_units};
        mm <= {mm_tens, mm_units};
        ss <= {ss_tens, ss_units};
    end
endmodule
