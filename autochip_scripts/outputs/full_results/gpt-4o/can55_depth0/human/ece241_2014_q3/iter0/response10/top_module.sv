module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Intermediate wires for the 2-to-1 multiplexers
    wire y0, y1;

    // 2-to-1 multiplexer for mux_in[0]
    assign y0 = d ? 1'b1 : c;
    assign mux_in[0] = y0;
    
    // 2-to-1 multiplexer for mux_in[1]
    assign mux_in[1] = 1'b0;

    // 2-to-1 multiplexer for mux_in[2]
    assign y1 = d ? 1'b1 : c;
    assign mux_in[2] = y1;

    // 2-to-1 multiplexer for mux_in[3]
    assign mux_in[3] = d;

endmodule
