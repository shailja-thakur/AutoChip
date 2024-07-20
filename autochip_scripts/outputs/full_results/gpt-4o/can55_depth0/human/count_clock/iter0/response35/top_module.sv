module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,   // Hours: Tens digit in hh[7:4], Units digit in hh[3:0]
    output reg [7:0] mm,   // Minutes: Tens digit in mm[7:4], Units digit in mm[3:0]
    output reg [7:0] ss    // Seconds: Tens digit in ss[7:4], Units digit in ss[3:0]
);

    // Value of 12 in BCD is 8'h12
    localparam BCD_12 = 8'h12;
    // Value of 9 in BCD is 8'h09
    localparam BCD_09 = 8'h09;
    // Value of 5 in BCD is 8'h05
    localparam BCD_05 = 8'h05;

    // Clock Reset - set to 12:00:00 AM
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= BCD_12;
            pm <= 1'b0;  // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'd9) begin
                ss[3:0] <= 4'd0;
                if (ss[7:4] == 4'd5) begin
                    ss[7:4] <= 4'd0;

                    // Increment minutes
                    if (mm[3:0] == 4'd9) begin
                        mm[3:0] <= 4'd0;
                        if (mm[7:4] == 4'd5) begin
                            mm[7:4] <= 4'd0;

                            // Increment hours
                            if (hh[3:0] == 4'd9) begin
                                hh[3:0] <= 4'd0;
                                if (hh[7:4] == 4'd1) begin
                                    hh[7:4] <= 4'd0;
                                    if (hh == BCD_12) begin
                                        hh <= 8'h01;
                                        pm <= ~pm;  // Toggle AM/PM
                                    end
                                end else begin
                                    hh[7:4] <= hh[7:4] + 4'd1;
                                end
                            end else if ((hh == 8'h11)) begin
                                hh <= BCD_12;
                            end else begin
                                hh[3:0] <= hh[3:0] + 4'd1;
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 4'd1;
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 4'd1;
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 4'd1;
                end
            end else begin
                ss[3:0] <= ss[3:0] + 4'd1;
            end
        end
    end
endmodule
