module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Binary-coded decimal counters
    always @(posedge clk) begin
        if (reset) begin
            // Reset the clock to 12:00 AM
            hh <= 8'b00010010;  // 12 in BCD
            mm <= 8'b00000000;  // 00 in BCD
            ss <= 8'b00000000;  // 00 in BCD
            pm <= 0;            // AM
        end else if (ena) begin
            // Increment the second counter
            if (ss[3:0] == 4'h9) begin
                ss[3:0] <= 4'h0;
                if (ss[7:4] == 4'h5) begin
                    ss[7:4] <= 4'h0;
                    // Increment the minute counter
                    if (mm[3:0] == 4'h9) begin
                        mm[3:0] <= 4'h0;
                        if (mm[7:4] == 4'h5) begin
                            mm[7:4] <= 4'h0;
                            // Increment the hour counter
                            if (hh[3:0] == 4'h9) begin
                                hh[3:0] <= 4'h0;
                                if (hh[7:4] == 4'h1) begin
                                    hh[7:4] <= 4'h0;
                                    pm <= ~pm; // Flip AM/PM
                                end else begin
                                    hh[7:4] <= hh[7:4] + 1;
                                end
                            end else if (hh == 8'h12) begin
                                hh <= 8'h01; // Wrap around to 01
                                pm <= ~pm;   // Flip AM/PM
                            end else begin
                                hh[3:0] <= hh[3:0] + 1;
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
