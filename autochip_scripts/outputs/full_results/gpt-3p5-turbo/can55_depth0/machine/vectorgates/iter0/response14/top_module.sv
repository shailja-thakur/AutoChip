module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    
    // Create intermediate wires for the operations
    wire [2:0] bitwise_or;
    wire logical_or;
    wire [5:0] bitwise_not;

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = (a != 0) || (b != 0);

    // Bitwise NOT operation
    assign bitwise_not = ~{a, b};
    assign out_not = bitwise_not;
endmodule
