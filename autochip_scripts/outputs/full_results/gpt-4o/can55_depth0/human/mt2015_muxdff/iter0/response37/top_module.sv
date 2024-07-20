module ff_mux (
    input clk,
    input L,
    input q_in,
    input r_in,
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
    output [2:0] q
);

// Instantiate ff_mux three times
ff_mux u0 (
    .clk(clk),
    .L(L),
    .q_in(q[1] ^ q[2]),
    .r_in(r[0]),
    .q_out(q[0])
);

ff_mux u1 (
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[1]),
    .q_out(q[1])
);

ff_mux u2 (
    .clk(clk),
    .L(L),
    .q_in(q[2]),
    .r_in(r[2]),
    .q_out(q[2])
);

endmodule
