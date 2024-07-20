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
            // Reset clock to 12:00:00 AM
            hh <= 8'h12; // 12 in BCD
            mm <= 8'h00; // 00 in BCD
            ss <= 8'h00; // 00 in BCD
            pm <= 1'b0;  // AM
        end
        else if (ena) begin
            // Increment seconds
            if (ss[3:0] == 4'd9) begin
                if (ss[7:4] == 4'd5) begin
                    ss <= 8'h00; // Reset seconds to 00 and increment minutes
                end
                else begin
                    ss <= {ss[7:4] + 4'd1, 4'd0}; // Increment the higher BCD digit
                end
            end
            else begin
                ss <= ss + 1'b1; // Increment the lower BCD digit
            end
            
            // Increment minutes if seconds wrap around
            if (ss == 8'h00) begin
                if (mm[3:0] == 4'd9) begin
                    if (mm[7:4] == 4'd5) begin
                        mm <= 8'h00; // Reset minutes to 00 and increment hours
                    end
                    else begin
                        mm <= {mm[7:4] + 4'd1, 4'd0}; // Increment the higher BCD digit
                    end
                end
                else begin
                    mm <= mm + 1'b1; // Increment the lower BCD digit
                end
            end
            
            // Increment hours if minutes wrap around
            if (ss == 8'h00 && mm == 8'h00) begin
                if (hh == 8'h12) begin
                    hh <= 8'h01; // Wrap around to 01 and toggle AM/PM
                    pm <= ~pm;
                end
                else if (hh[3:0] == 4'd9) begin
                    hh <= {hh[7:4] + 4'd1, 4'd0}; // Increment the higher BCD digit
                end
                else begin
                    hh <= hh + 1'b1; // Increment the lower BCD digit
                end
            end
        end
    end

endmodule
