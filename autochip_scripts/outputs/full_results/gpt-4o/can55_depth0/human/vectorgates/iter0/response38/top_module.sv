module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    // Compute bitwise OR
    assign out_or_bitwise = a | b;

    // Compute logical OR
    assign out_or_logical = a || b;

    // Compute inverse (NOT)
    assign out_not[2:0] = ~a; // inverse of a in the lower half [2:0]
    assign out_not[5:3] = ~b; // inverse of b in the upper half [5:3]

endmodule
