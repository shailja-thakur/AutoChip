module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    // Perform bitwise OR
    wire [2:0] bitwise_or;
    assign bitwise_or = a | b;
    assign out_or_bitwise = bitwise_or;
    
    // Perform logical OR
    wire logical_or;
    assign logical_or = (a != 0) || (b != 0);
    assign out_or_logical = logical_or;

    // Perform bitwise NOT in reverse order
    wire [5:0] bitwise_not_a;
    wire [5:0] bitwise_not_b;
    assign bitwise_not_a = ~a;
    assign bitwise_not_b = ~b;
    assign out_not = {bitwise_not_b, bitwise_not_a};
endmodule
