module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Initialize to 12:00:00 AM
    initial begin
        hh = 8'b00010010; // 12 (BCD)
        mm = 8'b00000000; // 00 (BCD)
        ss = 8'b00000000; // 00 (BCD)
        pm = 0;
    end

    always @(posedge clk) begin
        if (reset) begin
            // Reset clock to 12:00:00 AM
            hh <= 8'b00010010; // 12 (BCD)
            mm <= 8'b00000000; // 00 (BCD)
            ss <= 8'b00000000; // 00 (BCD)
            pm <= 0;
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'b1001) begin
                ss[3:0] <= 4'b0000;
                if (ss[7:4] == 4'b0101) begin
                    ss[7:4] <= 4'b0000;
                    // Increment minutes
                    if (mm[3:0] == 4'b1001) begin
                        mm[3:0] <= 4'b0000;
                        if (mm[7:4] == 4'b0101) begin
                            mm[7:4] <= 4'b0000;
                            // Increment hours
                            if (hh == 8'b00010010) begin
                                hh <= 8'b00000001;
                                pm <= ~pm; // Toggle AM/PM
                            end
                            else if (hh[3:0] == 4'b1001) begin
                                hh[3:0] <= 4'b0000;
                                hh[7:4] <= hh[7:4] + 1;
                            end
                            else begin
                                hh[3:0] <= hh[3:0] + 1;
                            end
                        end
                        else begin
                            mm[7:4] <= mm[7:4] + 1;
                        end
                    end
                    else begin
                        mm[3:0] <= mm[3:0] + 1;
                    end
                end
                else begin
                    ss[7:4] <= ss[7:4] + 1; 
                end
            end
            else begin
                ss[3:0] <= ss[3:0] + 1; 
            end
        end
    end
endmodule
