module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign outputs based on K-map
    assign mux_in[0] = d;               // ab = 00; f(0, 0) = d
    assign mux_in[1] = 0;               // ab = 01; f(0, 1) = 0
    assign mux_in[2] = c | d;           // ab = 11; f(1, 1) = c + d
    assign mux_in[3] = c | (~c & ~d);   // ab = 10; f(1, 0) = c + (~c * ~d) = 1

endmodule
