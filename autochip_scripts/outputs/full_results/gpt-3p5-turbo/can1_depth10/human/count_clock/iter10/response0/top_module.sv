module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] hour_tens;
    reg [3:0] hour_ones;
    reg [3:0] minute_tens;
    reg [3:0] minute_ones;
    reg [3:0] second_tens;
    reg [3:0] second_ones;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh <= 8'b00000000; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 1'b0; // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b01011010) begin // 59 in BCD
                ss <= 8'b00000000; // 00 in BCD

                // Increment minutes
                if (mm == 8'b01011010) begin // 59 in BCD
                    mm <= 8'b00000000; // 00 in BCD

                    // Increment hours
                    if (hh == 8'b00010010) begin // 12 in BCD
                        hh <= 8'b00000000; // 01 in BCD
                        if (pm) begin
                            pm <= 1'b0; // AM
                        end else begin
                            pm <= 1'b1; // PM
                        end
                    end else begin
                        hh <= hh + 8'b00000001;
                    end
                end else begin
                    mm <= mm + 8'b00000001;
                end
            end else begin
                ss <= ss + 8'b00000001;
            end
        end
    end

    // Assign BCD values to segments
    assign hour_tens = hh[7:4];
    assign hour_ones = hh[3:0];
    assign minute_tens = mm[7:4];
    assign minute_ones = mm[3:0];
    assign second_tens = ss[7:4];
    assign second_ones = ss[3:0];

endmodule
