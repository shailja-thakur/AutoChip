module mux_flipflop(
    input wire clk,
    input wire L,
    input wire r,
    input wire q_in,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r;
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
    wire q1, q2;

    // Instantiate submodule mux_flipflop
    mux_flipflop u1 (
        .clk(clk),
        .L(L),
        .r(r[0]),
        .q_in(q2 ^ q[2]),
        .Q(q[0])
    );

    mux_flipflop u2 (
        .clk(clk),
        .L(L),
        .r(r[1]),
        .q_in(q[0]),
        .Q(q[1])
    );

    mux_flipflop u3 (
        .clk(clk),
        .L(L),
        .r(r[2]),
        .q_in(q[1]),
        .Q(q[2])
    );

endmodule
