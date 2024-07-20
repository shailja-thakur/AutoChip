module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [3:0] hh1, hh2; // Separate BCD digits for hours
    reg [3:0] mm1, mm2; // Separate BCD digits for minutes
    reg [3:0] ss1, ss2; // Separate BCD digits for seconds
    reg [23:0] count = 0;

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010;  // Set initial value to 12 AM
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 1'b0;
            count <= 0;
        end else if (ena) begin
            // Calculate next values
            ss2 = ss[3:0] + 4'd1;
            ss1 = ss[7:4];
            mm2 = mm[3:0];
            mm1 = mm[7:4];
            hh2 = hh[3:0];
            hh1 = hh[7:4];

            if (ss2 == 4'd10) begin
                ss2 <= 4'd0;  // Reset seconds to 0
                ss1 <= ss1 + 4'd1;      // Increment tens digit of seconds
                if (ss1 == 4'd6) begin
                    ss1 <= 4'd0;  // Reset tens digit of seconds to 0
                    mm2 <= mm2 + 4'd1;      // Increment ones digit of minutes
                    if (mm2 == 4'd10) begin
                        mm2 <= 4'd0;  // Reset ones digit of minutes to 0
                        mm1 <= mm1 + 4'd1;      // Increment tens digit of minutes
                        if (mm1 == 4'd6) begin
                            mm1 <= 4'd0;  // Reset tens digit of minutes to 0
                            hh2 <= hh2 + 4'd1;      // Increment ones digit of hours
                            if (hh2 == 4'd10 && hh1 == 4'd0) begin
                                hh2 <= 4'd0;  // Reset ones digit of hours to 0
                                hh1 <= 4'd1;  // Increment tens digit of hours to 1
                                pm <= ~pm;  // Toggle AM/PM indicator
                            end else if (hh2 == 4'd10 && hh1 == 4'd1) begin
                                hh2 <= 4'd0;  // Reset ones digit of hours to 0
                                hh1 <= 4'd0;  // Reset tens digit of hours to 0
                                pm <= ~pm;  // Toggle AM/PM indicator
                            end else if (hh2 != 4'd10) begin
                                hh2 <= hh2 + 4'd1; // Increment ones digit of hours
                            end
                        end
                    end
                end
            end

            // Combine BCD digits back to single values
            ss <= {ss1, ss2};
            mm <= {mm1, mm2};
            hh <= {hh1, hh2};

            count <= count + 1;
        end
    end

    always @(posedge clk) begin
        if (count == 24_000_000) begin
            count <= 0;
        end
    end

endmodule
