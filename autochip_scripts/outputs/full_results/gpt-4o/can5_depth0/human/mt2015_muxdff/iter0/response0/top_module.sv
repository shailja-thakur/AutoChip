module flipflop_mux(
    input clk,
    input L,
    input D0,
    input D1,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= D1;
    end else begin
        Q <= D0;
    end
end

endmodule
module top_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire q1, q0, q2;

    flipflop_mux ffm0 (
        .clk(clk),
        .L(L),
        .D0(q1 ^ q2),
        .D1(r[0]),
        .Q(q[0])
    );

    flipflop_mux ffm1 (
        .clk(clk),
        .L(L),
        .D0(q[0]),
        .D1(r[1]),
        .Q(q[1])
    );

    flipflop_mux ffm2 (
        .clk(clk),
        .L(L),
        .D0(q[2]),
        .D1(r[2]),
        .Q(q[2])
    );

endmodule
