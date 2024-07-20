module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    // Bitwise OR operation on 3-bit inputs a and b
    assign out_or_bitwise = a | b;
    
    // Logical OR operation on 3-bit inputs a and b, treating each as a single logical entity
    assign out_or_logical = a != 3'b000 || b != 3'b000;
    
    // Bitwise NOT operation on 3-bit inputs a and b, combined into a 6-bit output
    assign out_not = {~b, ~a};
    
endmodule
