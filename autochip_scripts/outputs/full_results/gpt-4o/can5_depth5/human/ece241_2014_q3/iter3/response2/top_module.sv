module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define the output mux_in based on the provided Karnaugh map
    // mux_in[0] - ab = 00, representing the first column in the K-map
    assign mux_in[0] = ~c & d | c & ~d | c & d; // Values are 1 for (cd) = 01, 10, 11

    // mux_in[1] - ab = 01, representing the second column in the K-map
    assign mux_in[1] = 1'b0; // Values are 0 for all (cd)

    // mux_in[2] - ab = 10, representing the fourth column in the K-map
    assign mux_in[2] = (c & d) | (~c & ~d); // Values are 1 for (cd) = 00, 11

    // mux_in[3] - ab = 11, representing the third column in the K-map
    assign mux_in[3] = c & d | c & ~d | ~c & d | ~c & ~d; // Values are 1 for (cd) = 00, 01, 10, 11

endmodule
