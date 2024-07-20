module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] temp;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign temp[0] = (c & d) | (~c & d);
    assign temp[1] = (c & d) | (c & ~d);

    // Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = temp[0];
    assign mux_in[2] = temp[1];
    assign mux_in[3] = 1'b0;

endmodule
