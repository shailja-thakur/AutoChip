module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation (0 if both inputs are 0, 1 otherwise)
    assign out_or_logical = (a != 3'b000) || (b != 3'b000);

    // Bitwise NOT operation (concatenated outputs)
    assign out_not = {~a, ~b};

endmodule
