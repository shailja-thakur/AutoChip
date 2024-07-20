module flipflop_mux(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    reg [2:0] q;

    always @(posedge clk) begin
        if (L) begin
            q <= r_in;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

    assign Q = q_in;

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire Q1, Q2, Q3;

    flipflop_mux flipflop1(
        .clk(clk),
        .L(L),
        .q_in(q_in),
        .r_in(r_in),
        .Q(Q1)
    );

    flipflop_mux flipflop2(
        .clk(clk),
        .L(L),
        .q_in(Q1),
        .r_in(r_in),
        .Q(Q2)
    );

    flipflop_mux flipflop3(
        .clk(clk),
        .L(L),
        .q_in(Q2),
        .r_in(r_in),
        .Q(Q3)
    );

    assign Q = Q3;

endmodule
