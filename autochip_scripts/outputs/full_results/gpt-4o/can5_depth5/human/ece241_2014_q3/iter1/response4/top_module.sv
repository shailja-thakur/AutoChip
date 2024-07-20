module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Based on the given Karnaugh map values, we directly assign the corresponding outputs.
    // The values from the K-map correspond to the mux_in values directly.
    assign mux_in[0] = (~c & ~d & 1'b1) | (c & ~d & 1'b1) | (c & d & 1'b1);
    assign mux_in[1] = (~c & d & 1'b1);
    assign mux_in[2] = (c & d & 1'b1);
    assign mux_in[3] = (~c & ~d & 1'b1) | (c & ~d & 1'b1);

endmodule
