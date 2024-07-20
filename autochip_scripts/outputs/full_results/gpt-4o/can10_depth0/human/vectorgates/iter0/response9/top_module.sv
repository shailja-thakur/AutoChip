module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    // Bitwise OR of the vectors a and b
    assign out_or_bitwise = a | b;

    // Logical OR of the vectors a and b
    assign out_or_logical = |(a | b);

    // Inverse (NOT) of the vectors, placing inverse of b in bits [5:3] and inverse of a in bits [2:0]
    assign out_not = {~b, ~a};

endmodule
