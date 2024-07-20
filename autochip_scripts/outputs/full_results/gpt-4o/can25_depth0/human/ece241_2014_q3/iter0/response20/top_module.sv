module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Given the K-map, we derive the values for mux_in:
    // ab = 00: mux_in[0] = c'd + cd = d (as d is common in both the terms)
    // ab = 01: mux_in[1] = 0
    // ab = 11: mux_in[2] = c'd + cd' + cd = c' + d (as it covers all possible combinations when ab=11)
    // ab = 10: mux_in[3] = cd' + cd = c (as c is common in both the terms)

    assign mux_in[0] = d;
    assign mux_in[1] = 0;
    assign mux_in[2] = ~c | d;
    assign mux_in[3] = c;
endmodule
