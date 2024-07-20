module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Outputs for a'b'
    assign mux_in[0] = (~c & d) | (c & ~d) | (c & d);
    
    // Outputs for a'b
    assign mux_in[1] = 1'b0;

    // Outputs for ab
    assign mux_in[2] = (c & d);

    // Outputs for ab'
    assign mux_in[3] = (~c & ~d) | (c & d) | (~c & d);

endmodule
