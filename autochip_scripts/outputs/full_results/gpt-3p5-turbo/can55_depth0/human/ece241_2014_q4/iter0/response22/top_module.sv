module top_module (
    input clk,
    input x,
    output reg z
);

reg flipflop1;
reg flipflop2;
reg flipflop3;

always @(posedge clk) begin
    flipflop1 <= x ^ flipflop1;
    flipflop2 <= x & ~flipflop2;
    flipflop3 <= x | ~flipflop3;
    z <= ~(flipflop1 ^ flipflop2 ^ flipflop3);
end

endmodule
