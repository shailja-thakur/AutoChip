module top_module (
    input [7:0] in,
    output parity
);
    // assign the output port to the bitwise XOR of the input port
    assign parity = ^in;
    
endmodule
