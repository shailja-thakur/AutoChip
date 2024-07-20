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

    // Concatenate all inputs and a constant 2'b11 at the end
    wire [41:0] concatenated = {a, b, c, d, e, f, 2'b11};

    // Assign concatenated bits to outputs
    assign w = concatenated[7:0];
    assign x = concatenated[15:8];
    assign y = concatenated[23:16];
    assign z = concatenated[31:24];

endmodule
