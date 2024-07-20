module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else if (ena[1] && ena[2] && ena[3]) begin
            q <= q + 1;
        end
    end
endmodule
