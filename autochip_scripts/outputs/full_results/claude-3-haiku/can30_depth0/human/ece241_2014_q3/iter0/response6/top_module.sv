module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire p, q;
    
    // Implement the Karnaugh map using 2-to-1 multiplexers
    assign p = (c & ~d) | (~c & d);
    assign q = (c & d) | (~c & d);
    
    // Connect the outputs to the 4-to-1 multiplexer
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = p;
    assign mux_in[2] = (c & d) | (c & ~d);
    assign mux_in[3] = 1'b1;

endmodule
