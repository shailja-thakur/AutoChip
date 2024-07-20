module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:0] y,
    output [7:0] z
);

    // Concatenate the inputs and the constant 2'b11
    wire [32:0] combined;
    assign combined = {a, b, c, d, e, f, 2'b11};

    // Assign concatenated values to the outputs
    assign w = combined[7:0];
    assign x = combined[15:8];
    assign y = combined[23:16];
    assign z = combined[31:24];

endmodule
