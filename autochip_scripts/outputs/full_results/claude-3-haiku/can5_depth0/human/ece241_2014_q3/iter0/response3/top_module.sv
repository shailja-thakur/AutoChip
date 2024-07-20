module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire x, y;
    
    // Implement the Karnaugh map using multiplexers
    assign x = (c & ~d) | (~c & d);
    assign y = (c & d) | (~c & d) | (c & ~d);
    
    assign mux_in[0] = 1;
    assign mux_in[1] = x;
    assign mux_in[2] = y;
    assign mux_in[3] = x | y;

endmodule
