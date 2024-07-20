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

    wire [27:0] concatenated;

    assign concatenated = {a, b, c, d, e, f, 2'b11};
    assign w = concatenated[27:20];
    assign x = concatenated[19:12];
    assign y = concatenated[11:4];
    assign z = concatenated[3:0];

endmodule
