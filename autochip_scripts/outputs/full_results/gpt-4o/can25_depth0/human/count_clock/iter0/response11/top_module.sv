module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Initialize hours, minutes, seconds and pm
    initial begin
        hh = 8'b00010010; // 12
        mm = 8'b00000000; // 00
        ss = 8'b00000000; // 00
        pm = 1'b0; // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            hh <= 8'b00010010; // 12
            mm <= 8'b00000000; // 00
            ss <= 8'b00000000; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'b01011001) begin // 59
                ss <= 8'b00000000; // 00
                // Increment minutes
                if (mm == 8'b01011001) begin // 59
                    mm <= 8'b00000000; // 00
                    // Increment hours
                    if (hh == 8'b00010010) begin // 12
                        hh <= 8'b00000001; // 01
                        pm <= ~pm; // Toggle AM/PM
                    end else if (hh == 8'b00010001) begin // 11
                        hh <= 8'b00010010; // 12
                    end else begin
                        hh[3:0] <= hh[3:0] + 4'b0001;
                    end
                end else if (mm[3:0] == 4'b1001) begin // _9 
                    mm[7:4] <= mm[7:4] + 4'b0001;
                    mm[3:0] <= 4'b0000;
                end else begin
                    mm[3:0] <= mm[3:0] + 4'b0001;
                end
            end else if (ss[3:0] == 4'b1001) begin // _9
                ss[7:4] <= ss[7:4] + 4'b0001;
                ss[3:0] <= 4'b0000;
            end else begin
                ss[3:0] <= ss[3:0] + 4'b0001;
            end
        end
    end
endmodule
