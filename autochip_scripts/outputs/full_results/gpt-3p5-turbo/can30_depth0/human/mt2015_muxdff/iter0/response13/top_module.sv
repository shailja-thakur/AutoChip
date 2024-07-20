module flipflop(
    input clk,
    input r,
    output reg q
);

    always @(posedge clk)
    begin
        q <= r;
    end

endmodule
module mux_2to1(
    input r,
    input q,
    input l,
    output reg q_out
);

    always @(r or q or l)
    begin
        if (l)
        begin
            q_out <= r;
        end
        else
        begin
            q_out <= q;
        end
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire q_ff1, q_ff2, q_ff3;
    wire r_ff1, r_ff2, r_ff3;
    reg q_mux1, q_mux2, q_mux3;

    flipflop ff1 (
        .clk(clk),
        .r(r_ff1),
        .q(q_ff1)
    );

    flipflop ff2 (
        .clk(clk),
        .r(r_ff2),
        .q(q_ff2)
    );

    flipflop ff3 (
        .clk(clk),
        .r(r_ff3),
        .q(q_ff3)
    );

    mux_2to1 mux1 (
        .r(r_ff1),
        .q(q_ff2),
        .l(L),
        .q_out(q_mux1)
    );

    mux_2to1 mux2 (
        .r(r_ff2),
        .q(q_ff3),
        .l(L),
        .q_out(q_mux2)
    );

    mux_2to1 mux3 (
        .r(r_in),
        .q(q_in),
        .l(L),
        .q_out(q_mux3)
    );

    assign Q = q_mux3;

endmodule
