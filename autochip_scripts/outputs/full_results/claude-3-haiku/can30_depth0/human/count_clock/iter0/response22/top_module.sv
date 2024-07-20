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
        hh <= 8'h12; // Initialize to 12:00 AM
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 0;
    end
    else if (ena) begin
        ss <= (ss == 8'h59) ? 8'h00 : ss + 8'h01; // Increment seconds
        if (ss == 8'h59) begin
            mm <= (mm == 8'h59) ? 8'h00 : mm + 8'h01; // Increment minutes
            if (mm == 8'h59) begin
                hh <= (hh == 8'h12) ? 8'h01 : (hh == 8'h11) ? 8'h12 : hh + 8'h01; // Increment hours
                pm <= (hh == 8'h12) ? ~pm : pm; // Toggle AM/PM
            end
        end
    end
end

endmodule
