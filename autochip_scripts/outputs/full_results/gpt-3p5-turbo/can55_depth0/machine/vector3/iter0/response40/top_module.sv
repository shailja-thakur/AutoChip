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
    wire [7:0] concat; // Intermediate wire for concatenation

    assign concat = {a, b, c, d, e, f, 2'b11}; // Concatenating input ports with 2'b11

    assign w = concat[7:0]; // Output the first 8 bits of the concatenation
    assign x = concat[15:8]; // Output the next 8 bits of the concatenation
    assign y = concat[23:16]; // Output the next 8 bits of the concatenation
    assign z = concat[31:24]; // Output the last 8 bits of the concatenation
endmodule
