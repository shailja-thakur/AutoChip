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
        hh <= 8'h12; // 12:00 AM
        mm <= 8'h00;
        ss <= 8'h00;
        pm <= 1'b0; // AM
    end
    else if (ena) begin
        if (ss == 8'h59) begin
            ss <= 8'h00;
            if (mm == 8'h59) begin
                mm <= 8'h00;
                if (hh == 8'h12 && pm == 1'b0) begin
                    // Transition from AM to PM
                    hh <= 8'h01;
                    pm <= 1'b1;
                end
                else if (hh == 8'h12 && pm == 1'b1) begin
                    // Transition from PM to AM
                    hh <= 8'h01;
                    pm <= 1'b0;
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
