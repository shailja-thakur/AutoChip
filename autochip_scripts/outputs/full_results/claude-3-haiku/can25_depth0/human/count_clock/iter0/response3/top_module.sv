module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 1'b0;
    end
    else if (ena) begin
        // Increment the seconds counter
        if (ss == 8'h59) begin
            ss <= 8'h00;
            // Increment the minutes counter
            if (mm == 8'h59) begin
                mm <= 8'h00;
                // Increment the hours counter
                if (hh == 8'h12) begin
                    hh <= 8'h01;
                    pm <= ~pm;
                end
                else begin
                    hh <= hh + 8'h01;
                end
            end
            else begin
                mm <= mm + 8'h01;
            end
        end
        else begin
            ss <= ss + 8'h01;
        end
    end
end

endmodule
