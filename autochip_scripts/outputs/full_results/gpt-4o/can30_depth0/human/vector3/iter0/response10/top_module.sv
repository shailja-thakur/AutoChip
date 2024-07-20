module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:8] y,
    output [7:8] z
);

    // Concatenating the inputs and adding two 1 bits at the end
    wire [31:0] combined = {a, b, c, d, e, f, 2'b11};

    // Splitting the combined 32-bit vector into four 8-bit output vectors
    assign w = combined[31:24];
    assign x = combined[23:16];
    assign y = combined[15:8];
    assign z = combined[7:0];

endmodule
