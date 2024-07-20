module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire x, y, z;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign x = (c & ~d) | (~c & d);
    assign y = (~c & ~d);
    assign z = (c & ~d) | (c & d) | (~c & d);

    // Connect the outputs to the 4-to-1 multiplexer
    assign mux_in[0] = x;
    assign mux_in[1] = y;
    assign mux_in[2] = z;
    assign mux_in[3] = (c & d);

endmodule
