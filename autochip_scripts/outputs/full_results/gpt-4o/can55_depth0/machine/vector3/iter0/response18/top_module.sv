module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    assign {w[4:0], x[4:0], y[4:0], z[4:0], w[5], x[5], y[5], z[5], w[6], x[6], y[6], z[6], w[7], x[7], y[7], z[7]} = {a, b, c, d, e, f, 2'b11};

endmodule
