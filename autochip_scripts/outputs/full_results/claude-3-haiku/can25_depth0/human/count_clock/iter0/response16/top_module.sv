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
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 0;
    end
    else if (ena) begin
        // Increment seconds
        if (ss == 8'h59) begin
            ss <= 8'h00;
            // Increment minutes
            if (mm == 8'h59) begin
                mm <= 8'h00;
                // Increment hours
                if (hh == 8'h12) begin
                    hh <= 8'h01;
                    pm <= ~pm;
                end
                else
                    hh <= hh + 8'h01;
            end
            else
                mm <= mm + 8'h01;
        end
        else
            ss <= ss + 8'h01;
    end
end

endmodule
