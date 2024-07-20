module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = c | d; // Logical OR of the inputs
    assign mux_in[1] = 0;     // Second bit is 0
    assign mux_in[2] = ~d;    // Logical NOT of the input d
    assign mux_in[3] = c & d; // Logical AND of the inputs

endmodule
