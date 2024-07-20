module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // Initialize the clock to "12:00 AM"
    initial begin
        hh = 8'h12;  // 12 in BCD
        mm = 8'h00;  // 00 in BCD
        ss = 8'h00;  // 00 in BCD
        pm = 1'b0;   // AM
    end

    // Clock transition
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset
            hh <= 8'h12;  // 12 in BCD
            mm <= 8'h00;  // 00 in BCD
            ss <= 8'h00;  // 00 in BCD
            pm <= 1'b0;   // AM
        end else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'h9) begin
                if (ss[7:4] == 4'h5) begin
                    ss <= 8'h00;  // Roll over seconds
                    // Increment minutes
                    if (mm[3:0] == 4'h9) begin
                        if (mm[7:4] == 4'h5) begin
                            mm <= 8'h00;  // Roll over minutes
                            // Increment hours
                            if (hh[3:0] == 4'h9) begin
                                if (hh[7:4] == 4'h0) begin
                                    hh <= 8'h10;  // 10 in BCD
                                end else if (hh[7:4] == 4'h1) begin
                                    hh <= 8'h00;  // 00 in BCD which we will convert to 12 next
                                end
                            end else if (hh == 8'h12) begin
                                hh <= 8'h01;  // 01 in BCD
                                pm <= ~pm;  // Toggle AM/PM
                            end else begin
                                hh[3:0] <= hh[3:0] + 4'h1;
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 4'h1;
                            mm[3:0] <= 4'h0;
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 4'h1;
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 4'h1;
                    ss[3:0] <= 4'h0;
                end
            end else begin
                ss[3:0] <= ss[3:0] + 4'h1;
            end
        end
    end

endmodule
