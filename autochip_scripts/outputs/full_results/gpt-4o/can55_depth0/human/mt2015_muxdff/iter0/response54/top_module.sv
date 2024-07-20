module sub_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg q_out
);

always @(posedge clk) begin
    if (L) begin
        q_out <= r_in;
    end else begin
        q_out <= q_in;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] Q
);

wire [2:0] Q_intermediate;

sub_module u0 (
    .clk(clk),
    .L(L),
    .r_in(r[0]),
    .q_in(Q[2] ^ Q[1]),
    .q_out(Q_intermediate[0])
);

sub_module u1 (
    .clk(clk),
    .L(L),
    .r_in(r[1]),
    .q_in(Q[0]),
    .q_out(Q_intermediate[1])
);

sub_module u2 (
    .clk(clk),
    .L(L),
    .r_in(r[2]),
    .q_in(Q[2]),
    .q_out(Q_intermediate[2])
);

assign Q = Q_intermediate;

endmodule
