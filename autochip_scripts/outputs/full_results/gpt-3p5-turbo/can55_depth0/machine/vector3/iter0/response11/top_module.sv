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

    // Concatenation of inputs a, b, c, d, e, f, and a 2-bit constant value
    wire [39:0] concatenate;
    assign concatenate = {a, b, c, d, e, f, 2'b11};

    // Output assignment of the concatenated value to the desired ports
    assign w = concatenate[39:32];
    assign x = concatenate[31:24];
    assign y = concatenate[23:16];
    assign z = concatenate[15:8];

endmodule
