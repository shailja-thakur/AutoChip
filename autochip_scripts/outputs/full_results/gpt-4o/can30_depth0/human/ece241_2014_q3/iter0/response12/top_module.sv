module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Using the Karnaugh map provided:
    // ab
    // cd   00 01 11 10
    //  00 | 0 | 0 | 0 | 1 |
    //  01 | 1 | 0 | 0 | 0 |
    //  11 | 1 | 0 | 1 | 1 |
    //  10 | 1 | 0 | 0 | 1 |
    
    // The goal is to generate mux_in[3:0] for the multiplexer
    // Assign values based on the K-map
    assign mux_in[0] = (~c & ~d) ? 1'b0 : (c & ~d) ? 1'b1 : (c & d) ? 1'b1 : (~c & d) ? 1'b1 : 1'b0; // cd = 00
    assign mux_in[1] = 1'b0; // cd = 01, all zeros
    assign mux_in[2] = (c & d) ? 1'b1 : 1'b0; // cd = 11
    assign mux_in[3] = (~c & d) ? 1'b1 : 1'b0; // cd = 10
    
endmodule
