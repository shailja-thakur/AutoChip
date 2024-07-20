module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // BCD converters
    wire [3:0] hh_ones = hh[3:0];
    wire [3:0] hh_tens = hh[7:4];
    wire [3:0] mm_ones = mm[3:0];
    wire [3:0] mm_tens = mm[7:4];
    wire [3:0] ss_ones = ss[3:0];
    wire [3:0] ss_tens = ss[7:4];

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // 12-hour format, BCD 12:00 AM
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0; // AM
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h11) begin
                        hh <= hh + 1;
                        if (pm)
                            pm <= 0; // Switch to AM when 12 PM transitions to 1 AM
                        else
                            pm <= 1; // Switch to PM when 12 AM transitions to 1 PM
                    end else if (hh[3:0] == 4'h9) begin
                        hh <= {hh_tens + 1, 4'h0}; // Increment tens place
                    end else begin
                        hh <= hh + 1;
                    end
                end else if (mm_ones == 4'h9) begin
                    mm <= {mm_tens + 1, 4'h0}; // Increment tens place
                end else begin
                    mm <= mm + 1;
                end 
            end else if (ss_ones == 4'h9) begin
                ss <= {ss_tens + 1, 4'h0}; // Increment tens place
            end else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
