module flipflop_mux(
    input clk,
    input L,
    input r,
    input q_in,
    output reg q_out
);
    always @(posedge clk) begin
        if (L) begin
            q_out <= r;
        end else begin
            q_out <= q_in;
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
    wire temp_q1, temp_q2, temp_q3;

    // Instantiate the flipflop_mux submodule three times
    flipflop_mux u0 (
        .clk(clk),
        .L(L),
        .r(r_in[0]),
        .q_in(temp_q1),
        .q_out(q0)
    );

    flipflop_mux u1 (
        .clk(clk),
        .L(L),
        .r(r_in[1]),
        .q_in(temp_q2),
        .q_out(q1)
    );

    flipflop_mux u2 (
        .clk(clk),
        .L(L),
        .r(r_in[2]),
        .q_in(temp_q3),
        .q_out(q2)
    );

    assign temp_q1 = q1 ^ q2;
    assign temp_q2 = q0;
    assign temp_q3 = q2;

    assign Q = {q2, q1, q0};

endmodule
