module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire m1, m2, m3, m4;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign m1 = (~c & ~d);
assign m2 = (c & ~d);
assign m3 = (c & d);
assign m4 = (~c & d);

// Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer inputs
assign mux_in[0] = m1;
assign mux_in[1] = m2;
assign mux_in[2] = m3;
assign mux_in[3] = m4;

endmodule
