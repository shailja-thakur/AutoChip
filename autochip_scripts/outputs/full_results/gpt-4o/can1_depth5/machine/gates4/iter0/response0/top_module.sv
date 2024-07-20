module top_module (
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Perform logical AND on all bits of the input
    assign out_and = in[0] & in[1] & in[2] & in[3];
    
    // Perform logical OR on all bits of the input
    assign out_or = in[0] | in[1] | in[2] | in[3];
    
    // Perform logical XOR on all bits of the input
    assign out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];

endmodule
