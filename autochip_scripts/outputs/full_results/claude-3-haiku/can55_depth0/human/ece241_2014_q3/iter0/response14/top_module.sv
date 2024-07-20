module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire x, y, z;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign x = (c & ~d) | (~c & d);
assign y = c & d;
assign z = (c & d) | (~c & d);

// Assign the outputs to the 4-to-1 multiplexer inputs
assign mux_in[0] = 1'b1;
assign mux_in[1] = x;
assign mux_in[2] = y;
assign mux_in[3] = z;

endmodule
