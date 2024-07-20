module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 0; // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'b1001) begin // If the second one's digit is 9
                if (ss[7:4] == 4'b0101) begin // If the second ten's digit is 5
                    ss <= 8'b00000000; // Reset seconds to 00
                    // Increment minutes
                    if (mm[3:0] == 4'b1001) begin // If the minute one's digit is 9
                        if (mm[7:4] == 4'b0101) begin // If the minute ten's digit is 5
                            mm <= 8'b00000000; // Reset minutes to 00
                            // Increment hours
                            if (hh[3:0] == 4'b1001) begin // If the hour one's digit is 9
                                if (hh[7:4] == 4'b0001) begin // If the hour ten's digit is 1
                                    hh <= 8'b00010000; // Set hours to 10
                                end else begin
                                    hh[3:0] <= hh[3:0] + 1; // Increment hour one's digit
                                end
                            end else if ((hh[3:0] == 4'b0010) && (hh[7:4] == 4'b0001)) begin // If the hour is 12
                                hh <= 8'b00010001; // Set hours to 01
                                pm <= ~pm; // Toggle am/pm
                            end else begin
                                hh[3:0] <= hh[3:0] + 1; // Increment hour one's digit
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 1; // Increment minute ten's digit
                            mm[3:0] <= 4'b0000; // Reset minute one's digit
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 1; // Increment minute one's digit
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 1; // Increment second ten's digit
                    ss[3:0] <= 4'b0000; // Reset second one's digit
                end
            end else begin
                ss[3:0] <= ss[3:0] + 1; // Increment second one's digit
            end
        end
    end
endmodule
