module submodule(
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
    wire q0_out, q1_out, q2_out;

    submodule u0 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(0), // Initial input for the first flip-flop
        .q_out(q0_out)
    );

    submodule u1 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q0_out), // Input from the first flip-flop
        .q_out(q1_out)
    );

    submodule u2 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q1_out), // Input from the second flip-flop
        .q_out(q2_out)
    );

    assign q = {q2_out, q1_out, q0_out};
endmodule
