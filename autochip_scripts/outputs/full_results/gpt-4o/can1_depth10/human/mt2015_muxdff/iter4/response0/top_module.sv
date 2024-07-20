module flipflop_mux (
    input wire clk,
    input wire L,
    input wire q_in,
    input wire r_in,
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
    input wire clk,
    input wire L,
    input wire [2:0] r,
    output wire [2:0] q
);

    wire q0, q1, q2;

    flipflop_mux U0 (
        .clk(clk),
        .L(L),
        .q_in(q[1] ^ q[2]),
        .r_in(r[0]),
        .q_out(q0)
    );

    flipflop_mux U1 (
        .clk(clk),
        .L(L),
        .q_in(q[0]),
        .r_in(r[1]),
        .q_out(q1)
    );

    flipflop_mux U2 (
        .clk(clk),
        .L(L),
        .q_in(q[1]),
        .r_in(r[2]),
        .q_out(q2)
    );

    assign q = {q2, q1, q0};

endmodule
