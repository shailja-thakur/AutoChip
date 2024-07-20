module submodule(
    input clk,
    input L,
    input d,
    input r,
    output reg q
);
    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= d;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_internal;

    // Instantiate the submodule three times
    submodule u0 (
        .clk(clk),
        .L(L),
        .d(q_internal[1] ^ q_internal[2]),
        .r(r[0]),
        .q(q_internal[0])
    );

    submodule u1 (
        .clk(clk),
        .L(L),
        .d(q_internal[0]),
        .r(r[1]),
        .q(q_internal[1])
    );

    submodule u2 (
        .clk(clk),
        .L(L),
        .d(q_internal[2]),
        .r(r[2]),
        .q(q_internal[2])
    );

    assign q = q_internal;
endmodule
