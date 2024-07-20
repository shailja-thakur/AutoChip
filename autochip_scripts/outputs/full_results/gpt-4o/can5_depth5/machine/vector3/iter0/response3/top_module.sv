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
    // Concatenate the inputs with 2'b11 at the end
    wire [31:0] concat = {a, b, c, d, e, f, 2'b11};

    assign w = concat[31:24];
    assign x = concat[23:16];
    assign y = concat[15:8];
    assign z = concat[7:0];

endmodule
