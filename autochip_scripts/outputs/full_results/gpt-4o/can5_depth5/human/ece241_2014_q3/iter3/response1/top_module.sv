module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define the output mux_in based on the provided Karnaugh map
    assign mux_in[0] = c | (~c & d); // 1 for (c,d) = 10, 11
    assign mux_in[1] = ~c & d; // 1 for (c,d) = 01
    assign mux_in[2] = (c & ~d) | (c & d); // 1 for (c,d) = 10, 11
    assign mux_in[3] = c; // 1 for (c,d) = 10, 11

endmodule
