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

    wire [37:0] concatenated;

    assign concatenated = {a, b, c, d, e, f, 2'b11};

    assign w = concatenated[37:30];
    assign x = concatenated[29:22];
    assign y = concatenated[21:14];
    assign z = concatenated[13:6];

endmodule
