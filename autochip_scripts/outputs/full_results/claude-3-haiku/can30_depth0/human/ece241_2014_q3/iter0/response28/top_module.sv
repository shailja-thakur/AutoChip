module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire n1, n2, n3;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign n1 = (c & ~d) | (~c & d);
assign n2 = (c & ~d) | (c & d);
assign n3 = (c & d) | (~c & d);

// Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
assign mux_in[0] = 1'b1;
assign mux_in[1] = n1;
assign mux_in[2] = n2;
assign mux_in[3] = n3;

endmodule
