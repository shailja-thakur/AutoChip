module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    reg slow_clk;
    always @(posedge clk) begin
        slow_clk <= slowena;
    end

    always @(posedge slow_clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (slow_clk) begin
            if (q == 4'b1001)
                q <= 4'b0000;
            else
                q <= q + 1;
        end
    end

endmodule
