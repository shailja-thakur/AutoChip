module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] tens_hh, ones_hh, tens_mm, ones_mm, tens_ss, ones_ss;

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // "12" in BCD
            mm <= 8'b00000000; // "00" in BCD
            ss <= 8'b00000000; // "00" in BCD
            pm <= 0;           // AM
        end else if (ena) begin
            // Increment seconds
            if (ones_ss == 4'd9) begin
                ones_ss <= 4'd0;
                if (tens_ss == 4'd5) begin
                    tens_ss <= 4'd0;

                    // Increment minutes
                    if (ones_mm == 4'd9) begin
                        ones_mm <= 4'd0;
                        if (tens_mm == 4'd5) begin
                            tens_mm <= 4'd0;

                            // Increment hours
                            if (ones_hh == 4'd9 || (tens_hh == 1 && ones_hh == 4)) begin
                                if (tens_hh == 1 && ones_hh == 2) begin
                                    ones_hh <= 4'd1;
                                    tens_hh <= 4'd0;
                                    pm <= ~pm; // Toggle AM/PM
                                end else begin
                                    ones_hh <= ones_hh + 1;
                                    if (ones_hh == 4'd9) begin
                                        ones_hh <= 4'd0;
                                        tens_hh <= tens_hh + 1;
                                    end
                                end
                            end else begin
                                ones_hh <= ones_hh + 1;
                            end
                            if (tens_hh == 1 && ones_hh == 1) begin
                                ones_hh <= 4'd2; // Special case for 12 o'clock
                            end
                        end else begin
                            tens_mm <= tens_mm + 1;
                        end
                    end else begin
                        ones_mm <= ones_mm + 1;
                    end
                end else begin
                    tens_ss <= tens_ss + 1;
                end
            end else begin
                ones_ss <= ones_ss + 1;
            end

            // Combine BCD digits into outputs
            hh <= {tens_hh, ones_hh};
            mm <= {tens_mm, ones_mm};
            ss <= {tens_ss, ones_ss};
        end
    end

endmodule
