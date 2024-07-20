module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire mux1_out, mux2_out;

// Implement the Karnaugh map using two 2-to-1 multiplexers
assign mux1_out = (c & d) | (~c & d);
assign mux2_out = (c & ~d) | (c & d);

// Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer inputs
assign mux_in = {mux2_out, mux1_out, 2'b0};

endmodule
