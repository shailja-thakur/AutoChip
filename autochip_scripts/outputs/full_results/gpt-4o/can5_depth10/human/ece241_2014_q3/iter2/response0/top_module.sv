module top_module (
    input c,
    input d,
    output [3:0] mux_in
);
    // Correcting assignments based on the provided Karnaugh map
    
    // ab = 00
    assign mux_in[0] = d;
    // ab = 01
    assign mux_in[1] = 0;
    // ab = 11
    assign mux_in[2] = c | (~c & d); // When ab = 10, the output on mux adheres to the specific case scenario
    // ab = 10
    assign mux_in[3] = 1;

endmodule
