module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // BCD increments and resets for ss, mm, hh, and am/pm transition
    always @(posedge clk) begin
        if (reset) begin
            // Reset to "12:00 AM"
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 1'b0;
        end else if (ena) begin
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
                            if (hh[3:0] == 4'b1001) begin
                                hh[3:0] <= 4'b0000;
                                if (hh[7:4] == 4'h1) begin
                                    hh[7:4] <= 4'b0000;
                                    hh[3:0] <= 4'b0001; // Adjust to 1 from 0 for the first hour
                                    pm <= ~pm; //Toggle PM on 12 hour rollover
                                end else if (hh[7:4] == 4'b0000 && hh[3:0] == 4'b0010) begin
                                    hh[7:4] <= 4'b0001;
                                    hh[3:0] <= 4'b0001;
                                end else begin
                                    hh[7:4] <= hh[7:4] + 1;
                                end
                            end else if (hh == 8'h12) begin
                                hh <= 8'h01;
                                pm <= ~pm; //Toggle PM on 12 hour rollover
                            end else begin
                                hh[3:0] <= hh[3:0] + 1;
                            end
                        end else begin
                            mm[7:4] <= mm[7:4] + 1;
                        end
                    end else begin
                        mm[3:0] <= mm[3:0] + 1;
                    end
                end else begin
                    ss[7:4] <= ss[7:4] + 1;
                end
            end else begin
                ss[3:0] <= ss[3:0] + 1;
            end
        end
    end
endmodule
