module flipflop_mux (
    input clk,
    input L,
    input r_in,
    input q_in,
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
    wire q1, q2, q3;
    wire mux_out1, mux_out2, mux_out3;

    // Instance 1
    flipflop_mux f1 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q2 ^ q3),
        .q_out(q1)
    );

    // Instance 2
    flipflop_mux f2 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q1),
        .q_out(q2)
    );

    // Instance 3
    flipflop_mux f3 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q3),
        .q_out(q3)
    );

    assign q = {q3, q2, q1};

endmodule
