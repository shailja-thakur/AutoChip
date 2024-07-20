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

    wire [47:0] concatenation;
    assign concatenation = {a, b, c, d, e, f, 2'b11};

    assign w = concatenation[47:40];
    assign x = concatenation[39:32];
    assign y = concatenation[31:24];
    assign z = concatenation[23:16];

endmodule
