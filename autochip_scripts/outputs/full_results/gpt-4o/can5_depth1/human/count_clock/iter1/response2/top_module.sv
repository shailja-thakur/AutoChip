module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Reset values
    parameter BCD_12 = 8'h12;
    parameter BCD_00 = 8'h00;
    parameter BCD_01 = 8'h01;
    parameter BCD_11 = 8'h11;  // 11 BCD
    
    always @(posedge clk) begin
        if (reset) begin
            hh <= BCD_12;  // Initialize to 12:00 AM
            mm <= BCD_00;
            ss <= BCD_00;
            pm <= 1'b0;    // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= BCD_00;
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= BCD_00;
                    // Increment hours
                    if (hh == BCD_12) begin
                        hh <= BCD_01;
                    end else if (hh == BCD_11) begin
                        hh <= BCD_12;
                        pm <= ~pm;    // Toggle AM/PM
                    end else begin
                        if (hh[3:0] == 4'd9) begin
                            hh <= {hh[7:4] + 4'd1, 4'd0};
                        end else begin
                            hh <= hh + 8'd1;
                        end
                    end
                end else begin
                    if (mm[3:0] == 4'd9) begin
                        mm <= {mm[7:4] + 4'd1, 4'd0};
                    end else begin
                        mm <= mm + 8'd1;
                    end
                end
            end else begin
                if (ss[3:0] == 4'd9) begin
                    ss <= {ss[7:4] + 4'd1, 4'd0};
                end else begin
                    ss <= ss + 8'd1;
                end
            end
        end
    end
endmodule
