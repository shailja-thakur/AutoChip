module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define the output mux_in based on the provided Karnaugh map
    assign mux_in[0] = d;         // 1 for (c,d) = 10; 0 otherwise
    assign mux_in[1] = 1'b0;      // always 0
    assign mux_in[2] = (~c | d);  // 1 for (c,d) = 00, 01, 11
    assign mux_in[3] = (c & ~d) | (~c & ~d); // 1 for (c,d) = 00, 10

endmodule
