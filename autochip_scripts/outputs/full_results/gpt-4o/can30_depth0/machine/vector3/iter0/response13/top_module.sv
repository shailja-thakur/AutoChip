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

    assign w = {a, 3'b000};  // a is 5 bits, add 3 bits of padding to make 8 bits
    assign x = {b, 3'b000};  // b is 5 bits, add 3 bits of padding to make 8 bits
    assign y = {c, 3'b000};  // c is 5 bits, add 3 bits of padding to make 8 bits
    assign z = {d, e[2:0], e[4:3], f[4:1], 2'b11};  // d (5 bits), e (first 3 bits), e (last 2 bits), f (excluding 1st bit), and 2'b11

endmodule
