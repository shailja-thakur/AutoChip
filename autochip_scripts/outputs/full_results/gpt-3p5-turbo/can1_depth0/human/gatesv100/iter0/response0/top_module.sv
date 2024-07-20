module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Output for bit i in out_both
    // is 1 if in[i] and in[i+1] are both 1
    // Boundary condition: in[99] does not have a left neighbor
    assign out_both[0] = in[0] & in[99];
    assign out_both[97:0] = in[97:0] & in[98:1];

    // Output for bit i in out_any
    // is 1 if in[i] or in[i+1] are 1
    // Boundary condition: in[0] does not have a right neighbor
    assign out_any[99:1] = in[98:0] | in[99];

    // Output for bit i in out_different
    // is 1 if in[i] is different from in[i+1]
    // Boundary condition: in[99]'s neighbor to the left is in[0]
    assign out_different[98:0] = in[98:0] ^ in[99];
    assign out_different[99] = in[99] ^ in[0];

endmodule
