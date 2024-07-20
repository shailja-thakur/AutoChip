module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    // Perform bitwise OR operation between a and b
    assign out_or_bitwise = a | b;
    
    // Perform logical OR operation between a and b after combining bits
    assign out_or_logical = |a || |b;
    
    // Perform bitwise NOT operation on a and b, then concatenate in reverse order
    assign out_not = {~b, ~a};
    
endmodule
