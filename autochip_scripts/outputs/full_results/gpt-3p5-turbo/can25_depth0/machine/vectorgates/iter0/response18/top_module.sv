module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    // Define internal signals for bitwise and logical operations
    wire [2:0] bitwise_or;
    wire logic_or;
    
    // Perform bitwise OR operation
    assign bitwise_or = a | b;
    
    // Perform logical OR operation
    assign logic_or = (a != 0) || (b != 0);
    
    // Perform bitwise NOT operation
    assign out_not = ~{b, a};
    
    // Assign outputs
    assign out_or_bitwise = bitwise_or;
    assign out_or_logical = logic_or;

endmodule
