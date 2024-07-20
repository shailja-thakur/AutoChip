module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [3:0] hh,
    output reg [3:0] mm,
    output reg [3:0] ss
);

always @(posedge clk) begin
    if (reset) begin
        hh <= 4'h1;
        mm <= 4'h0;
        ss <= 4'h0;
        pm <= 0;
    end
    else if (ena) begin
        // Seconds
        if (ss == 4'h9) begin
            ss <= 4'h0;
            // Minutes
            if (mm == 4'h9) begin
                mm <= 4'h0;
                // Hours
                if (hh == 4'h1 && pm) begin
                    hh <= 4'h2;
                    pm <= 0;
                end
                else if (hh == 4'h1 && !pm) begin
                    hh <= 4'h1;
                    pm <= 1;
                end
                else if (hh == 4'h1) begin
                    hh <= 4'h1;
                end
                else begin
                    hh <= hh + 4'h1;
                end
            end
            else begin
                mm <= mm + 4'h1;
            end
        end
        else begin
            ss <= ss + 4'h1;
        end
    end
end

endmodule
