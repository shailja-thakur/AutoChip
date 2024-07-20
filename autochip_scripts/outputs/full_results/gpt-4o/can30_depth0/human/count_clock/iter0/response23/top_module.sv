module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Properly initialize hh, mm, ss, and pm
    initial begin
        hh = 8'h12;     // 12:00 AM
        mm = 8'h00;     // 00 minutes
        ss = 8'h00;     // 00 seconds
        pm = 1'b0;      // AM
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;  // 12:00 AM
            mm <= 8'h00;  // 00 minutes
            ss <= 8'h00;  // 00 seconds
            pm <= 1'b0;   // AM
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
                                if (hh[7:4] == 1'd1) begin  // from 12:59:59 to 1:00:00
                                    hh[7:4] <= 4'd0;
                                    pm <= ~pm;
                                end
                                else begin
                                    hh[7:4] <= hh[7:4] + 1;
                                end
                            end
                            else if (hh[3:0] == 4'd2 && hh[7:4] == 1'd1) begin  // 12-hour wrap around
                                hh <= 8'd1;  // go to 1 hour
                                pm <= ~pm;   // Toggle PM/AM
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
