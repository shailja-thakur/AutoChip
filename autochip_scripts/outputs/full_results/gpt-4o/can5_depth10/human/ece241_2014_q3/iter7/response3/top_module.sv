module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Based on the Karnaugh map
    // ab = 00
    assign mux_in[0] = (c & d) | (~c & d) | (~c & ~d & 1);
    
    // ab = 01
    assign mux_in[1] = 0;
    
    // ab = 11
    assign mux_in[3] = (c & d) | (c & ~d) | (~c & d);
    
    // ab = 10
    assign mux_in[2] = (c & d) | (~c & d);
    
endmodule
