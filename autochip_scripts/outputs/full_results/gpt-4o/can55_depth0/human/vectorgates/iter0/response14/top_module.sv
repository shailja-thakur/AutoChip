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
    assign out_or_logical = |a | |b;

    // Compute inverse (NOT)
    assign out_not = {~b, ~a};

endmodule
