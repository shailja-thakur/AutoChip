module top_module (
    input  [99:0] in,
    output        out_and,
    output        out_or,
    output        out_xor
);

    integer i;
    
    // Perform AND operation
    assign out_and = &in;
    
    // Perform OR operation
    assign out_or = |in;
    
    // Perform XOR operation
    assign out_xor = ^in;

endmodule
