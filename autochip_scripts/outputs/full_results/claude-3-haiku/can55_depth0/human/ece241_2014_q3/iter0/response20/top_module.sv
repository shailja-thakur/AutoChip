module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire not_c = ~c;
    wire not_d = ~d;
    
    // Implement the Karnaugh map using a 4-to-1 mux and 2-to-1 muxes
    assign mux_in[0] = not_c & not_d;
    assign mux_in[1] = c & not_d;
    assign mux_in[2] = c & d;
    assign mux_in[3] = not_c & d;

endmodule
