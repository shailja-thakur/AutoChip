module dff_mux(
    input clk,
    input L,
    input d0,
    input d1,
    output reg q
);
    always @(posedge clk) begin
        if (L) 
            q <= d1;
        else 
            q <= d0;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_next;

    assign q_next[0] = q[1] ^ q[2];
    assign q_next[1] = q[0];
    assign q_next[2] = q[2];

    dff_mux ff0 (
        .clk(clk),
        .L(L),
        .d0(q_next[0]),
        .d1(r[0]),
        .q(q[0])
    );

    dff_mux ff1 (
        .clk(clk),
        .L(L),
        .d0(q_next[1]),
        .d1(r[1]),
        .q(q[1])
    );

    dff_mux ff2 (
        .clk(clk),
        .L(L),
        .d0(q_next[2]),
        .d1(r[2]),
        .q(q[2])
    );
endmodule
