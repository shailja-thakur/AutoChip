module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

// Constants for BCD representation
localparam SECONDS_MAX = 59;
localparam MINUTES_MAX = 59;
localparam HOURS_MAX = 12;

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 0;
    end
    else if (ena) begin
        // Increment the clock
        if (ss == SECONDS_MAX) begin
            ss <= 8'h00;
            if (mm == MINUTES_MAX) begin
                mm <= 8'h00;
                if (hh == HOURS_MAX) begin
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
