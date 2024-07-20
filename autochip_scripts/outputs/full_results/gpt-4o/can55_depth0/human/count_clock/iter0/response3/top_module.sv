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
            // Reset the clock
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 1'b0;        // AM
        end else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'b1001) begin
                ss[3:0] <= 4'b0000;
                if (ss[7:4] == 4'b0101) begin
                    ss[7:4] <= 4'b0000;
                    // Increment minutes
                    if (mm[3:0] == 4'b1001) begin
                        mm[3:0] <= 4'b0000;
                        if (mm[7:4] == 4'b0101) begin
                            mm[7:4] <= 4'b0000;
                            // Increment hours
                            if (hh[3:0] == 4'b1001) begin
                                hh[3:0] <= 4'b0000;
                                if (hh == 8'b00010010) begin // 12 in BCD
                                    hh[7:4] <= 4'b0001;
                                    pm <= ~pm; // Toggle AM/PM
                                end else begin
                                    hh[7:4] <= hh[7:4] + 1;
                                end
                            end else begin
                                if (hh == 8'b00010010) begin // Hour is 12 in BCD
                                    hh[3:0] <= 4'b0001;   // Wrap around to 1
                                    hh[7:4] <= 8'b0;
                                end else begin
                                    hh[3:0] <= hh[3:0] + 1;
                                end
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 1;
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 1;
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 1;
                end
            end else begin
                ss[3:0] <= ss[3:0] + 1;
            end
        end
    end
endmodule
