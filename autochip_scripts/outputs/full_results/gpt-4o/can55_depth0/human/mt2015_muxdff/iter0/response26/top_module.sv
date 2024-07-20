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
    output reg [2:0] q
);

    wire Q0, Q1, Q2;

    top_module u0 (
        .clk(clk),
        .L(L),
        .q_in(q[1] ^ q[2]),
        .r_in(r[0]),
        .Q(Q0)
    );

    top_module u1 (
        .clk(clk),
        .L(L),
        .q_in(q[0]),
        .r_in(r[1]),
        .Q(Q1)
    );

    top_module u2 (
        .clk(clk),
        .L(L),
        .q_in(q[2]),
        .r_in(r[2]),
        .Q(Q2)
    );

    always @(posedge clk) begin
        q <= {Q2, Q1, Q0};
    end

endmodule
