module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    // Counters for hours, minutes, and seconds
    always @(posedge clk) begin
        if (reset) begin
            hh <= 12;
            mm <= 0;
            ss <= 0;
        end else if (ena) begin
            hh <= hh + 1;
            if (hh > 12) begin
                hh <= 1;
                pm <= 1;
            end
            mm <= mm + 1;
            if (mm > 59) begin
                mm <= 0;
            end
            ss <= ss + 1;
            if (ss > 59) begin
                ss <= 0;
            end
        end
    end

    // Output signals
    assign pm = (hh > 12);
    assign hh = hh[7:0];
    assign mm = mm[7:0];
    assign ss = ss[7:0];

endmodule