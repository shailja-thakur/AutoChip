module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;
wire nq1, nq2, nq3;

wire y1, y2, y3;

assign y1 = x ^ q1;
assign y2 = ~q2;
assign y3 = ~q3;

assign z = y1 ~^ y2 ~^ y3;

always @(posedge clk) begin
    d1 <= y1;
    d2 <= y2;
    d3 <= y3;
end

d_ff d_ff1 (
    .clk(clk),
    .d(d1),
    .q(q1),
    .nq(nq1)
);

d_ff d_ff2 (
    .clk(clk),
    .d(d2),
    .q(q2),
    .nq(nq2)
);

d_ff d_ff3 (
    .clk(clk),
    .d(d3),
    .q(q3),
    .nq(nq3)
);

endmodule
module d_ff (
    input clk,
    input d,
    output reg q,
    output reg nq
);

always @(posedge clk) begin
    q <= d;
    nq <= ~d;
end

endmodule
