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

    // Intermediate wire for concatenation output
    wire [47:0] concatenated;

    // Concatenation with 2'b11 at the end
    assign concatenated = {a, b, c, d, e, f, 2'b11};

    // Assign each 8-bit portion to the corresponding output
    assign w = concatenated[47:40];
    assign x = concatenated[39:32];
    assign y = concatenated[31:24];
    assign z = concatenated[23:16];

endmodule
