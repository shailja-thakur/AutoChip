module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Initialize clock values
    initial begin
        hh = 8'h12; // 12 in BCD
        mm = 8'h00; // 00 in BCD
        ss = 8'h00; // 00 in BCD
        pm = 0; // AM
    end

    // Sequential block for clock operation
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12; // 12 in BCD
            mm <= 8'h00; // 00 in BCD
            ss <= 8'h00; // 00 in BCD
            pm <= 0; // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    // Increment hours
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'h09) begin
                        hh <= 8'h10;
                    end else if (hh == 8'h19) begin
                        hh <= 8'h20;
                    end else if (hh == 8'h23) begin
                        hh <= 8'h00;
                    end else begin
                        hh <= hh + 1;
                    end
                end else begin
                    mm <= mm + 1;
                end
            end else begin
                ss <= ss + 1;
            end
        end
    end
endmodule
