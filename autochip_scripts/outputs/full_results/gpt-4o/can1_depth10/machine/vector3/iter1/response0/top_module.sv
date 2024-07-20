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

    wire [31:0] concat;

    assign concat = {a, b[4:2], b[1:0], c, d[4:2], d[1:0], e, f[4:2], f[1:0], 2'b11};

    assign w = concat[31:24];
    assign x = concat[23:16];
    assign y = concat[15:8];
    assign z = concat[7:0];

endmodule
