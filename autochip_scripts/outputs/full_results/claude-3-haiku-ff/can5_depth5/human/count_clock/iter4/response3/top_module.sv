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
        hh <= 4'd12;
        mm <= 4'd00;
        ss <= 4'd00;
        pm <= 0;
    end
    else if (ena) begin
        // Increment seconds
        if (ss == 4'd59) begin
            ss <= 4'd00;
            // Increment minutes
            if (mm == 4'd59) begin
                mm <= 4'd00;
                // Increment hours
                if (hh == 4'd12) begin
                    hh <= 4'd01;
                    pm <= ~pm;
                end
                else begin
                    hh <= hh + 4'd01;
                end
            end
            else begin
                mm <= mm + 4'd01;
            end
        end
        else begin
            ss <= ss + 4'd01;
        end
    end
end

endmodule
