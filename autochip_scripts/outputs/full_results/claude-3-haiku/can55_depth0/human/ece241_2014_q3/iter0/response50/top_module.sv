module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire temp1, temp2, temp3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign temp1 = (c & d) | (~c & d);
    assign temp2 = (c & ~d) | (~c & ~d);
    assign temp3 = (c & d) | (c & ~d) | (~c & d);

    // Connect the intermediate signals to the 4-to-1 multiplexer inputs
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = temp2;
    assign mux_in[2] = temp3;
    assign mux_in[3] = temp1;

endmodule
