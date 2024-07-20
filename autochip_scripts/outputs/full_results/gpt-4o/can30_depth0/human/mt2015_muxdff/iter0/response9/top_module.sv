module sub_module (
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
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire q0_next, q1_next, q2_next;

// Instantiate submodules for each bit
sub_module u0 (
    .clk(clk),
    .L(L),
    .q_in(r[1] ^ r[2]),
    .r_in(r[0]),
    .Q(q0_next)
);

sub_module u1 (
    .clk(clk),
    .L(L),
    .q_in(q0_next),
    .r_in(r[1]),
    .Q(q1_next)
);

sub_module u2 (
    .clk(clk),
    .L(L),
    .q_in(r[2]),
    .r_in(r[2]),
    .Q(q2_next)
);

assign q = {q2_next, q1_next, q0_next};

endmodule
