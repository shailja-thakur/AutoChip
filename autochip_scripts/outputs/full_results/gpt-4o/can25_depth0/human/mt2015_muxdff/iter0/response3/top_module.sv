module flipflop_mux(
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
module top_module(
    input clk,
    input L,
    input [2:0] r,
    input [2:0] q_in,
    output [2:0] q_out
);
    wire q_out0, q_out1, q_out2;

    flipflop_mux ff0 (
        .clk(clk),
        .L(L),
        .q_in(q_in[2] ^ q_in[1]),
        .r_in(r[0]),
        .Q(q_out[0])
    );

    flipflop_mux ff1 (
        .clk(clk),
        .L(L),
        .q_in(q_in[0]),
        .r_in(r[1]),
        .Q(q_out[1])
    );

    flipflop_mux ff2 (
        .clk(clk),
        .L(L),
        .q_in(q_in[2]),
        .r_in(r[2]),
        .Q(q_out[2])
    );
endmodule
