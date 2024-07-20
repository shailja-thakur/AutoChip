module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

    wire out1, out2, out3, out4;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign out1 = c;
    assign out2 = 1'b0;
    assign out3 = c | d;
    assign out4 = c | d;

    // Connect the outputs to the 4-to-1 multiplexer inputs
    assign mux_in[0] = out1;
    assign mux_in[1] = out2;
    assign mux_in[2] = out3;
    assign mux_in[3] = out4;

endmodule
