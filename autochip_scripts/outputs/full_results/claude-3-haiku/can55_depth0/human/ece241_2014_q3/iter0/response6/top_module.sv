module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

    wire s1, s2, s3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign s1 = c & d;
    assign s2 = ~c & d;
    assign s3 = c & ~d;

    assign mux_in[0] = s1;
    assign mux_in[1] = s2;
    assign mux_in[2] = s3;
    assign mux_in[3] = s1 | s3;

endmodule
