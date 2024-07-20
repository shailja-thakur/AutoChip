module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    reg slow_clk;
    reg slowclk_enable;
    always @(posedge clk) begin
        slow_clk <= slowena;
        slowclk_enable <= slowena;
    end

    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (slowclk_enable) begin
            if (q == 4'b1001)
                q <= 4'b0000;
            else
                q <= q + 1;
        end
    end

endmodule
