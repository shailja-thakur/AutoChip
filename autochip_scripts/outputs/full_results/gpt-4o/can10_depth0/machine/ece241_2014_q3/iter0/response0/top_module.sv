module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    assign mux_in[0] = c | d;      // First bit is the OR of inputs c and d
    assign mux_in[1] = 0;          // Second bit is 0
    assign mux_in[2] = ~d;         // Third bit is the NOT of input d
    assign mux_in[3] = c & d;      // Fourth bit is the AND of inputs c and d

endmodule
