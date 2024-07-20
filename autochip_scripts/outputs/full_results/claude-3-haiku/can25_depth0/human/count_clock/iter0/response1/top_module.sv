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
        if (ss == 8'h59) begin
            ss <= 8'h00;
            if (mm == 8'h59) begin
                mm <= 8'h00;
                if (hh == 8'h12 && pm) begin
                    hh <= 8'h01;
                    pm <= 0;
                end
                else if (hh == 8'h12 && !pm) begin
                    hh <= 8'h01;
                    pm <= 1;
                end
                else if (hh == 8'h11 && pm) begin
                    hh <= 8'h12;
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
