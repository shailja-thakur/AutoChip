module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define the output mux_in based on the provided Karnaugh map
    assign mux_in[0] = ~c & ~d;    // K-map: mux_in[0] = 1 for input combination (c,d) = 00
    assign mux_in[1] =  c & ~d;    // K-map: mux_in[1] = 1 for input combination (c,d) = 10
    assign mux_in[2] =  c & d;     // K-map: mux_in[2] = 1 for input combination (c,d) = 11
    assign mux_in[3] = ~c & d;     // K-map: mux_in[3] = 1 for input combination (c,d) = 01

endmodule
