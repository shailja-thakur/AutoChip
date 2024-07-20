module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Define the expressions for each mux_in output corresponding to the K-map

    assign mux_in[0] = (c & d) | (~c & d) | (c & ~d); // Represents ab = 00
    assign mux_in[1] = 0;                            // Represents ab = 01
    assign mux_in[2] = (c & d);                      // Represents ab = 11
    assign mux_in[3] = d;                            // Represents ab = 10
    
endmodule
