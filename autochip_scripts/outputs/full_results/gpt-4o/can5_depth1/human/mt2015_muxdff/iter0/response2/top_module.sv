module mux_flipflop (
    input clk,
    input L,
    input D0,
    input D1,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= D0;
        end else begin
            Q <= D1;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output [2:0] Q
);

    mux_flipflop u0 (
        .clk(clk),
        .L(L),
        .D0(r_in[0]),
        .D1(q_in[1] ^ q_in[2]),
        .Q(Q[0])
    );

    mux_flipflop u1 (
        .clk(clk),
        .L(L),
        .D0(r_in[1]),
        .D1(q_in[0]),
        .Q(Q[1])
    );

    mux_flipflop u2 (
        .clk(clk),
        .L(L),
        .D0(r_in[2]),
        .D1(q_in[2]),
        .Q(Q[2])
    );

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    top_module top_inst (
        .clk(clk),
        .L(L),
        .q_in(q),
        .r_in(r),
        .Q(q)
    );

endmodule
