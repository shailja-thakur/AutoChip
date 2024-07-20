module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

wire q0, q1, q2;
wire q0_in, q1_in, q2_in;

assign q0_in = q1 ^ q2;
assign q1_in = q[2];
assign q2_in = q[0];

top_module u0 (
    .clk(clk),
    .L(L),
    .q_in(q0_in),
    .r_in(r[0]),
    .Q(q[0])
);

top_module u1 (
    .clk(clk),
    .L(L),
    .q_in(q1_in),
    .r_in(r[1]),
    .Q(q[1])
);

top_module u2 (
    .clk(clk),
    .L(L),
    .q_in(q2_in),
    .r_in(r[2]),
    .Q(q[2])
);

endmodule
