module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

always @(posedge clk) begin
    if (reset) begin
        hh <= 8'h12; // 12:00 AM
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 1'b0;
    end else if (ena) begin
        // increment seconds
        if (ss[3:0] == 4'd9) begin
            ss[3:0] <= 4'd0;
            if (ss[7:4] == 4'd5) begin
                ss[7:4] <= 4'd0;
                // increment minutes
                if (mm[3:0] == 4'd9) begin
                    mm[3:0] <= 4'd0;
                    if (mm[7:4] == 4'd5) begin
                        mm[7:4] <= 4'd0;
                        // increment hours
                        if (hh[3:0] == 4'd9) begin
                            hh[3:0] <= 4'd0;
                            if (hh[7:4] == 4'd1 && hh[3:0] == 4'd2) begin
                                hh[7:4] <= 4'd0;
                                hh[3:0] <= 4'd1;
                                pm <= ~pm;
                            end else if (hh[7:4] == 4'd0) begin
                                hh[7:4] <= 4'd1;
                            end else begin
                                hh[7:4] <= 4'd0;
                                hh[3:0] <= hh[3:0] + 4'd1;
                            end
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
