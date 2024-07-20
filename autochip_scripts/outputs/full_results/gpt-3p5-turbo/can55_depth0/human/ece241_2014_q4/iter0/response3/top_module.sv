module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
reg q1, q2, q3;
wire not_q1, not_q2, not_q3;

assign not_q1 = ~q1;
assign not_q2 = ~q2;
assign not_q3 = ~q3;

assign z = ~(q1 ^ d1 & not_q2 ^ d2 & not_q3 ^ d3);

always @(posedge clk)
begin
    d1 <= x;
    d2 <= x;
    d3 <= x;
    q1 <= d1;
    q2 <= ~d2;
    q3 <= ~d3;
end

endmodule
