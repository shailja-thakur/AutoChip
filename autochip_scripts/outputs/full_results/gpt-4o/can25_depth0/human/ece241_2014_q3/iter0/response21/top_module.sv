module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // map the result of the Karnaugh Map to the mux inputs using the 4-to-1 and 2-to-1 multiplexers
    assign mux_in[0] = (!c & d) | (c & !d);     // K-map: ab=00 -> mux_in[0]
    assign mux_in[1] = 0;                        // K-map: ab=01 -> mux_in[1]
    assign mux_in[2] = (c & d) | (!c & d);        // K-map: ab=11 -> mux_in[2]
    assign mux_in[3] = (!c);                    // K-map: ab=10 -> mux_in[3]
endmodule
