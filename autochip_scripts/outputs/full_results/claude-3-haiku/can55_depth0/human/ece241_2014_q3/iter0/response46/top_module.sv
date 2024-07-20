module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire w1, w2, w3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign w1 = (c & ~d) | (~c & d);
    assign w2 = (c & ~d) | (c & d);
    assign w3 = (c & d);

    // Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer inputs
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = w1;
    assign mux_in[2] = w2;
    assign mux_in[3] = w3;

endmodule
