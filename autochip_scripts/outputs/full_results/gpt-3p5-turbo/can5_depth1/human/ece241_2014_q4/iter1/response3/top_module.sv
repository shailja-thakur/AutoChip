module top_module (
    input clk,
    input x,
    output reg z
);

reg d1, d2, d3;
reg q1, q2, q3;

assign z = ~(q1 ^ q2 ^ q3);

always @(posedge clk) begin
    d1 <= x ^ q1;
    d2 <= ~d2 & q1;
    d3 <= ~d3 | ~d2;
    q1 <= d1;
    q2 <= d2;
    q3 <= d3;
end

endmodule
