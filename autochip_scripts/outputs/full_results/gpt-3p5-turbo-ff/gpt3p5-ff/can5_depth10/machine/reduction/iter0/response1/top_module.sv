module top_module (
    input [7:0] in,
    output parity
);
   // Assign the output port to the bitwise XOR of the 8-bit input port
   assign parity = ^in;
endmodule
