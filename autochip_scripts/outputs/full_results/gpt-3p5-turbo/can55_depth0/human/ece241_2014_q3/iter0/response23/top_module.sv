module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire w1, w2, w3, w4;

    // Implement the first two inputs of the 4-to-1 mux
    assign w1 = ~(c & d);
    assign w2 = c & ~d;
    assign mux_in[0] = a & b ? w1 : w2;

    // Implement the third input of the 4-to-1 mux
    assign w3 = c | ~d;
    assign mux_in[1] = a & b ? 1'b0 : w3;

    // Implement the fourth input of the 4-to-1 mux
    assign w4 = c & d;
    assign mux_in[2] = a & b ? w4 : 1'b0;

    // Implement the remaining inputs of the 4-to-1 mux
    assign mux_in[3] = a & b ? 1'b0 : 1'b1;

endmodule
