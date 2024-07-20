module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire z1, z2, z3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign z1 = (c & ~d) | (~c & d);
    assign z2 = (c & ~d) | (c & d);
    assign z3 = (c & d) | (~c & d);

    // Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = z1;
    assign mux_in[2] = z2;
    assign mux_in[3] = z3;

endmodule
