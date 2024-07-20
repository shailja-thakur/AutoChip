module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] mux1_out;
wire [1:0] mux2_out;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign mux1_out[0] = d;
assign mux1_out[1] = 1'b0;

assign mux1_out[1] = c;
assign mux1_out[0] = 1'b0;

// Combine the outputs of the 2-to-1 multiplexers using a 4-to-1 multiplexer
assign mux_in[0] = mux1_out[0];
assign mux_in[1] = mux1_out[1];
assign mux_in[2] = (c & d) | (~c & d);
assign mux_in[3] = (c & d) | (c & ~d);

endmodule
