module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Assign values based on the Karnaugh map
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10
    
    assign mux_in[0] = d & ~c;  // K-map value at cd = 00, ab = 00
    assign mux_in[1] = 0;       // K-map value at cd = 00, ab = 01
    assign mux_in[2] = (c & d) | (~c & d); // K-map value at cd = 00, ab = 11
    assign mux_in[3] = (c & ~d) | (~c & d) ; // K-map value at cd = 00, ab = 10
    
endmodule
