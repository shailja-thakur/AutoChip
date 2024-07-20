module flipflop_mux(
    input clk,
    input L,
    input d,
    output reg q
);
    always @(posedge clk) begin
        if (L) begin
            q <= d;
        end else begin
            q <= q;
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

    flipflop_mux u0 (
        .clk(clk),
        .L(L),
        .d(r[0]),
        .q(q0)
    );
    
    flipflop_mux u1 (
        .clk(clk),
        .L(L),
        .d(r[1]),
        .q(q1)
    );

    flipflop_mux u2 (
        .clk(clk),
        .L(L),
        .d(r[2]),
        .q(q2)
    );

    assign q = {q2, q1, q0};
endmodule
