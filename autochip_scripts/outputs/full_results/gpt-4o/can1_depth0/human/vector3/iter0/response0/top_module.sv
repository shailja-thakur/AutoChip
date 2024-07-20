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

    // Concatenate input vectors and extra two 1 bits to form 32-bit intermediate signal
    wire [31:0] combined;
    assign combined = {a, b, c, d, e, f, 2'b11};

    // Split the 32-bit intermediate signal into four 8-bit output vectors
    assign w = combined[31:24];
    assign x = combined[23:16];
    assign y = combined[15:8];
    assign z = combined[7:0];

endmodule
