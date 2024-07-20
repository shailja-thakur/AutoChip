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

    wire [31:0] combined;

    // Concatenate input vectors and 2 bits (2'b11)
    assign combined = {a, b, c, d, e, f, 2'b11};

    // Split 32-bit combined vector into 8-bit output vectors
    assign w = combined[31:24];
    assign x = combined[23:16];
    assign y = combined[15:8];
    assign z = combined[7:0];

endmodule
