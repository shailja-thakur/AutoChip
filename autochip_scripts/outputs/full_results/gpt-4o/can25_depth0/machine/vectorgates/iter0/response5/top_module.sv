module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    // Assign bitwise OR of a and b to out_or_bitwise
    assign out_or_bitwise = a | b;
    
    // Assign logical OR of a and b to out_or_logical
    assign out_or_logical = |(a | b);
    
    // Assign bitwise NOT of a and b to out_not in reverse order
    assign out_not = {~b, ~a};

endmodule
