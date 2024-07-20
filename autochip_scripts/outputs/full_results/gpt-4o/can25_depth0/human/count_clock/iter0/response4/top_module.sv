module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    always @(posedge clk) begin
        if (reset) begin
            // Reset all outputs to initial value "12:00:00 AM"
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end else if (ena) begin
            // Seconds counter (00-59)
            if (ss[3:0] == 4'h9) begin
                ss[3:0] <= 4'h0;
                if (ss[7:4] == 4'h5) begin
                    ss[7:4] <= 4'h0;
                    // Minutes counter (00-59)
                    if (mm[3:0] == 4'h9) begin
                        mm[3:0] <= 4'h0;
                        if (mm[7:4] == 4'h5) begin
                            mm[7:4] <= 4'h0;
                            // Hours counter (01-12)
                            if (hh[3:0] == 4'h9) begin
                                hh[3:0] <= 4'h0;
                                if (hh[7:4] == 4'h1) begin
                                    hh[7:4] <= 4'h0;
                                    hh[3:0] <= 4'h1;  // Roll over to "01"
                                    pm <= ~pm; // Toggle PM indicator
                                end else begin
                                    hh[7:4] <= hh[7:4] + 1;
                                end
                            end else if (hh == 8'h12) begin
                                hh <= 8'h01;
                                pm <= ~pm; // Toggle PM indicator
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
