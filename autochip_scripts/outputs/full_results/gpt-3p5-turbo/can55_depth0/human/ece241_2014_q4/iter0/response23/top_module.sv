module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign q1 = d1;
assign q2 = !d2;
assign q3 = !d3;

assign z = ~(q1 ^ x) & ~(q2 & x) & ~(q3 | x);

always @(posedge clk) begin
    d1 <= x;
    d2 <= q1;
    d3 <= !q1;
end

endmodule
