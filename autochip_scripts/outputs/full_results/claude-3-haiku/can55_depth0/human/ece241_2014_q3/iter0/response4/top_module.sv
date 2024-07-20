module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire m1, m2, m3;

    // Implement the Karnaugh map using multiplexers
    assign m1 = (c & ~d) | (~c & d);
    assign m2 = (~c & ~d);
    assign m3 = (c & d);

    assign mux_in[0] = m1;
    assign mux_in[1] = m2;
    assign mux_in[2] = m3;
    assign mux_in[3] = (c & d) | (~c & d);

endmodule
