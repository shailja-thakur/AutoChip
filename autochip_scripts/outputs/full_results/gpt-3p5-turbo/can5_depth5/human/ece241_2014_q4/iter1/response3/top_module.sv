module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;
reg temp;

always @(posedge clk) begin
    temp <= d1; // Store previous value of d1
    d1 <= x ^ temp;
    d2 <= ~(d2 & temp);
    d3 <= ~(d3 | temp);
    z <= ~(d1 ^ d2 ^ d3);
end

endmodule
