module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assigning values to mux_in based on the corrected Karnaugh map
    assign mux_in[0] = (d & ~c) | (~d & ~c) | (d & c);
    assign mux_in[1] = 0;
    assign mux_in[2] = (c & d) | (d & ~c);
    assign mux_in[3] = (c & ~d) | (~c & ~d);

endmodule
