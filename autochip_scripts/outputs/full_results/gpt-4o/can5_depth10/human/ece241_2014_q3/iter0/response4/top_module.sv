module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement the Karnaugh map for each of the 4-to-1 mux inputs
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10

    assign mux_in[0] = (~d & c) | (d & ~c);
    assign mux_in[1] = 0;
    assign mux_in[2] = (d & c);
    assign mux_in[3] = 1;

endmodule
