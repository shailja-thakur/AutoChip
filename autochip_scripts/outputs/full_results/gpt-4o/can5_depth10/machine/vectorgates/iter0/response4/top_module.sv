module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    // Bitwise OR of the two 3-bit inputs
    assign out_or_bitwise = a | b;

    // Logical OR of the two 3-bit inputs
    // Logical OR returns a single bit value (1 if either operand is non-zero, otherwise 0)
    assign out_or_logical = (a != 3'b000) || (b != 3'b000);

    // Bitwise NOT of the two 3-bit inputs, concatenated in reverse order
    assign out_not = {~b, ~a};

endmodule
