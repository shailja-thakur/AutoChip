module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire t1, t2, t3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign t1 = (c & ~d) | (~c & d);
    assign t2 = (c & ~d) | (c & d);
    assign t3 = (c & d);

    // Connect the 2-to-1 multiplexer outputs to the 4-to-1 multiplexer inputs
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = t1;
    assign mux_in[2] = t2;
    assign mux_in[3] = t3;

endmodule
