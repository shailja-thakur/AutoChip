module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] next_hh, next_mm, next_ss;
    reg next_pm;

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            hh <= 8'b00010010; // 12
            mm <= 8'b00000000; // 00
            ss <= 8'b00000000; // 00
            pm <= 1'b0;  // AM
        end else if (ena) begin
            // Update seconds
            if (ss[3:0] == 4'b1001) begin
                if (ss[7:4] == 4'b0101) begin
                    next_ss = 8'b00000000;
                    // Update minutes
                    if (mm[3:0] == 4'b1001) begin
                        if (mm[7:4] == 4'b0101) begin
                            next_mm = 8'b00000000;
                            // Update hours
                            if (hh[3:0] == 4'b1001) begin
                                next_hh = {hh[7:4] == 4'b0001 ? 4'b0010 : 4'b0001, 4'b0000};
                                if (hh == 8'b00001001 || pm) begin
                                    next_pm = ~pm; // Toggle AM/PM
                                end
                            end else if (hh == 8'b00010010) begin
                                next_hh = 8'b00000001;
                            end else begin
                                next_hh = hh + 1;
                            end
                        end else begin
                            next_mm = {mm[7:4] + 1, 4'b0000};
                        end
                    end else begin
                        next_mm = mm + 1;
                    end
                end else begin
                    next_ss = {ss[7:4], ss[3:0] + 1};
                end
            end else begin
                next_ss = ss + 1;
            end
            
            // Update clock signals
            ss <= next_ss;
            mm <= next_mm;
            hh <= next_hh;
            pm <= next_pm;
        end
    end
endmodule
