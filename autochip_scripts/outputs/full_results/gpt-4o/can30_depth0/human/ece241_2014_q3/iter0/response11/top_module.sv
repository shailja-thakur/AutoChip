module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Specify the values for mux_in[3:0] based on the Karnaugh map
    assign mux_in[0] = (c & d) | (~c & ~d); // Corresponds to 00, 01, 10, and 11
    assign mux_in[1] = 1'b0; // Corresponds to 00, 01, 10, and 11
    assign mux_in[2] = (c & ~d); // Corresponds to 11
    assign mux_in[3] = (~c & d) | (c & ~d) | (~c & ~d); // Corresponds to 10, 11

endmodule
