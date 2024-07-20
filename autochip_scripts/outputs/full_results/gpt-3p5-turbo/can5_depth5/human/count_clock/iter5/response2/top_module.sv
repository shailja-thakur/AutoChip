module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [3:0] hh_tens;
    reg [3:0] hh_ones;
    reg [3:0] mm_tens;
    reg [3:0] mm_ones;
    reg [3:0] ss_tens;
    reg [3:0] ss_ones;
    reg [23:0] count = 0;

    always @(posedge clk) begin
        if (reset) begin
            hh_tens <= 4'b0001;  // Set initial value to 12 AM
            hh_ones <= 4'b0010;
            mm_tens <= 4'b0000;
            mm_ones <= 4'b0000;
            ss_tens <= 4'b0000;
            ss_ones <= 4'b0000;
            pm <= 1'b0;
            count <= 0;
        end else if (ena) begin
            // Calculate next values
            ss_ones = ss_ones + 4'b0001;
            if (ss_ones == 4'b1010) begin
                ss_ones <= 4'b0000;  // Reset ones digit of seconds to 0
                ss_tens <= ss_tens + 4'b0001;  // Increment tens digit of seconds
                if (ss_tens == 4'b0110) begin
                    ss_tens <= 4'b0000;  // Reset tens digit of seconds to 0
                    mm_ones <= mm_ones + 4'b0001;  // Increment ones digit of minutes
                    if (mm_ones == 4'b1010) begin
                        mm_ones <= 4'b0000;  // Reset ones digit of minutes to 0
                        mm_tens <= mm_tens + 4'b0001;  // Increment tens digit of minutes
                        if (mm_tens == 4'b0110) begin
                            mm_tens <= 4'b0000;  // Reset tens digit of minutes to 0
                            hh_ones <= hh_ones + 4'b0001;  // Increment ones digit of hours
                            if (hh_ones == 4'b1010) begin
                                hh_ones <= 4'b0000;  // Reset ones digit of hours to 0
                                hh_tens <= hh_tens + 4'b0001;  // Increment tens digit of hours
                                if (hh_tens == 4'b0001_1010) begin
                                    hh_tens <= 4'b0000;  // Reset tens digit of hours to 0
                                    pm <= ~pm;  // Toggle AM/PM indicator
                                end
                            end
                        end
                    end
                end
            end

            count <= count + 1;
        end
    end

    always @(posedge clk) begin
        if (count == 24_000_000) begin
            count <= 0;
        end
    end

    // Assign the output values
    assign hh = {hh_tens, hh_ones};
    assign mm = {mm_tens, mm_ones};
    assign ss = {ss_tens, ss_ones};

endmodule
