module flipflop_mux (
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
    // Wires to connect the flipflops
    wire q0, q1, q2;

    // Instantiate the submodules
    flipflop_mux ffm0 (
        .clk(clk),
        .L(L),
        .d(q1 ^ q2),
        .r(r[0]),
        .q(q0)
    );

    flipflop_mux ffm1 (
        .clk(clk),
        .L(L),
        .d(q0),
        .r(r[1]),
        .q(q1)
    );

    flipflop_mux ffm2 (
        .clk(clk),
        .L(L),
        .d(q2),
        .r(r[2]),
        .q(q2)
    );

    // Assign outputs
    assign q = {q2, q1, q0};
endmodule
