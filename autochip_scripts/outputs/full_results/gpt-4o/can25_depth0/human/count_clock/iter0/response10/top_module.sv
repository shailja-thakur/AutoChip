module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // BCD counters for the seconds
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'b00000000;
        end else if (ena) begin
            if (ss[3:0] == 4'b1001) begin
                if (ss[7:4] == 4'b0101) begin
                    ss <= 8'b00000000;
                end else begin
                    ss <= {ss[7:4] + 1'b1, 4'b0000};
                end
            end else begin
                ss <= ss + 1'b1;
            end
        end
    end

    // BCD counters for the minutes
    always @(posedge clk) begin
        if (reset) begin
            mm <= 8'b00000000;
        end else if (ena && ss == 8'b00000000) begin
            if (mm[3:0] == 4'b1001) begin
                if (mm[7:4] == 4'b0101) begin
                    mm <= 8'b00000000;
                end else begin
                    mm <= {mm[7:4] + 1'b1, 4'b0000};
                end
            end else begin
                mm <= mm + 1'b1;
            end
        end
    end

    // BCD counters for the hours and PM flag
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00010010; // 12 in BCD
            pm <= 1'b0; // AM
        end else if (ena && ss == 8'b00000000 && mm == 8'b00000000) begin
            if (hh[3:0] == 4'b1001 || (hh[7:4] == 4'b0001 && hh[3:0] == 4'b0010)) begin
                if (hh[7:4] == 4'b0001 && hh[3:0] == 4'b0010) begin
                    hh <= 8'b00010001; // 01 in BCD
                end else if (hh[7:4] == 4'b0000 && hh[3:0] == 4'b1001) begin
                    hh <= {hh[7:4] + 1'b1, 4'b0000}; // Increment tens place
                end else begin
                    hh <= 8'b00010010; // 12 in BCD
                    pm <= ~pm;
                end
            end else begin
                hh <= hh + 1'b1;
            end
        end
    end

endmodule
