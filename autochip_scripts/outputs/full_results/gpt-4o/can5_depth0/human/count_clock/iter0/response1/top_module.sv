module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Initialize the registers
    initial begin
        hh = 8'b00010010; // 12 in BCD
        mm = 8'b00000000; // 00 in BCD
        ss = 8'b00000000; // 00 in BCD
        pm = 1'b0;        // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            hh <= 8'b00010010; // 12 in BCD
            mm <= 8'b00000000; // 00 in BCD
            ss <= 8'b00000000; // 00 in BCD
            pm <= 1'b0;        // AM
        end 
        else if (ena) begin
            // Update seconds
            if (ss == 8'b01011001) begin // 59 in BCD
                ss <= 8'b00000000; // Reset to 00 and increment minutes
                if (mm == 8'b01011001) begin // 59 in BCD
                    mm <= 8'b00000000; // Reset to 00 and increment hours
                    if (hh == 8'b00010010) begin // 12 in BCD
                        hh <= 8'b00000001; // Reset to 01 and toggle am/pm
                        pm <= ~pm;        // Toggle am/pm
                    end else if (hh == 8'b00010001) begin // 11 in BCD
                        hh <= 8'b00100000; // Go to 12
                    end else if (hh[3:0] == 8'b00001001) begin // BCD increment for 1x:xx
                        hh <= {hh[7:4] + 1'b1, 4'b0000};
                    end else begin
                        hh <= hh + 1'b1;
                    end
                end else if (mm[3:0] == 8'b00001001) begin // x9 minutes
                    mm <= {mm[7:4] + 1'b1, 4'b0000};
                end else begin
                    mm <= mm + 1'b1;
                end
            end else if (ss[3:0] == 8'b00001001) begin // x9 seconds
                ss <= {ss[7:4] + 1'b1, 4'b0000};
            end else begin
                ss <= ss + 1'b1;
            end
        end
    end
endmodule
