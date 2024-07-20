module dff_mux (
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
    wire q0, q1, q2;

    dff_mux dff_mux0(
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q[1] ^ q[2]),
        .q_out(q0)
    );

    dff_mux dff_mux1(
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q[0]),
        .q_out(q1)
    );

    dff_mux dff_mux2(
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q[1]),
        .q_out(q2)
    );

    assign q = {q2, q1, q0};

endmodule
