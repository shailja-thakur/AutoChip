module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign the first bit of mux_in to the logical OR of c and d
    assign mux_in[0] = c | d;
    
    // Assign the second bit of mux_in to 0
    assign mux_in[1] = 0;
    
    // Assign the third bit of mux_in to the logical NOT of d
    assign mux_in[2] = ~d;
    
    // Assign the fourth bit of mux_in to the logical AND of c and d
    assign mux_in[3] = c & d;

endmodule
