module flipflop_2to1_mux (
    input clk,
    input L,
    input r_in,
    input q_in_0,
    input q_in_1,
    input q_in_2,
    output reg Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in_1 ^ q_in_2;
        end
    end
endmodule
module top_module(
	input clk,
	input L,
	input [2:0] r_in,
	output [2:0] Q
);

    wire q0, q1, q2;

    // Instantiate three flipflop_2to1_mux submodules
    flipflop_2to1_mux ffm0 (
        .clk(clk),
        .L(L),
        .r_in(r_in[0]),
        .q_in_0(q0),
        .q_in_1(Q[1]),
        .q_in_2(Q[2]),
        .Q(Q[0])
    );

    flipflop_2to1_mux ffm1 (
        .clk(clk),
        .L(L),
        .r_in(r_in[1]),
        .q_in_0(q1),
        .q_in_1(Q[0]),
        .q_in_2(Q[2]),
        .Q(Q[1])
    );

    flipflop_2to1_mux ffm2 (
        .clk(clk),
        .L(L),
        .r_in(r_in[2]),
        .q_in_0(q2),
        .q_in_1(Q[0]),
        .q_in_2(Q[1]),
        .Q(Q[2])
    );

endmodule
