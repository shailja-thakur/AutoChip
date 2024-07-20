module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire x1, x2, x3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign x1 = (~c & ~d);
    assign x2 = (c & ~d);
    assign x3 = (c & d);

    // Connect the mux_in outputs
    assign mux_in[0] = x1;
    assign mux_in[1] = x2;
    assign mux_in[2] = x3;
    assign mux_in[3] = (~c & d);

endmodule
