module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire temp1, temp2;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign temp1 = (c & ~d) | (~c & d);
    assign temp2 = (c & d);

    // Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
    assign mux_in[0] = ~temp1;
    assign mux_in[1] = temp1;
    assign mux_in[2] = temp2;
    assign mux_in[3] = ~temp2;

endmodule
