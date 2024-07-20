module flop_mux(
    input clk,
    input L,
    input D1,
    input D2,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= D1;
        end else begin
            Q <= D2;
        end
    end
endmodule
module top_module(
    input clk,
    input [2:0] r,
    input L,
    output [2:0] q
);
    wire [2:0] next_q;

    assign next_q[0] = q[1] ^ q[2];
    assign next_q[1] = q[0];
    assign next_q[2] = q[2];

    flop_mux instance0 (
        .clk(clk),
        .L(L),
        .D1(r[0]),
        .D2(next_q[0]),
        .Q(q[0])
    );

    flop_mux instance1 (
        .clk(clk),
        .L(L),
        .D1(r[1]),
        .D2(next_q[1]),
        .Q(q[1])
    );

    flop_mux instance2 (
        .clk(clk),
        .L(L),
        .D1(r[2]),
        .D2(next_q[2]),
        .Q(q[2])
    );
endmodule
