module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement the Karnaugh map using a 4-to-1 multiplexer and 2-to-1 multiplexers
    wire out1, out2, out3;

    // 2-to-1 multiplexers
    assign out1 = (c & d) | (~c & d);
    assign out2 = (c & ~d) | (~c & ~d);
    assign out3 = (c & d) | (~c & d) | (c & ~d);

    // 4-to-1 multiplexer
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = out1;
    assign mux_in[2] = out3;
    assign mux_in[3] = (c & d) | (~c & d) | (c & ~d);

endmodule
