module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire s1, s2, s3;

    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign s1 = c ? 1'b1 : 1'b0;
    assign s2 = (c & d) ? 1'b1 : 1'b0;
    assign s3 = (c & ~d) ? 1'b1 : 1'b0;

    // Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer inputs
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = s1;
    assign mux_in[2] = s2;
    assign mux_in[3] = s3;

endmodule
