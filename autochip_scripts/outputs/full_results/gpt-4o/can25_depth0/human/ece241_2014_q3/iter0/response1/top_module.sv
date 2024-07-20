module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implementing the K-map using only multiplexers
    wire mux2_1_0, mux2_1_1, mux2_1_2;

    // Mux to determine mux_in[0] based on 'c' and 'd'
    // mux_in[0] = (c'd') = ~c & ~d
    assign mux2_1_0 = ~c;

    // Mux to determine mux_in[1] based on 'c' and 'd'
    // mux_in[1] = (c'd) = ~c & d
    assign mux2_1_1 = d;

    // Mux to determine mux_in[2] based on 'c' and 'd'
    // mux_in[2] = (cd') = c & ~d
    assign mux2_1_2 = c;

    assign mux_in[0] = mux2_1_0 & ~d;
    assign mux_in[1] = ~d & mux2_1_1;
    assign mux_in[2] = c & d;
    // mux_in[3] = 1 as it is a constant '1'
    assign mux_in[3] = 1;

endmodule
