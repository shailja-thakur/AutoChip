module dff_mux(
    input clk,
    input L,
    input d,
    input r,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r;
        end else begin
            Q <= d;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

    wire q0, q1, q2;
    wire d0, d1, d2;

    assign d0 = q2 ^ q1;
    assign d1 = q0;
    assign d2 = q2;

    dff_mux dff0(
        .clk(clk),
        .L(L),
        .d(d0),
        .r(r[0]),
        .Q(q[0])
    );

    dff_mux dff1(
        .clk(clk),
        .L(L),
        .d(d1),
        .r(r[1]),
        .Q(q[1])
    );

    dff_mux dff2(
        .clk(clk),
        .L(L),
        .d(d2),
        .r(r[2]),
        .Q(q[2])
    );

endmodule
