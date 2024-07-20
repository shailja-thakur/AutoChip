module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Implement the Karnaugh map using 2-to-1 multiplexers

wire [1:0] mux1_out;
wire [1:0] mux2_out;

// First level of multiplexers
assign mux1_out[0] = d;
assign mux1_out[1] = 1'b0;

assign mux2_out[0] = d;
assign mux2_out[1] = 1'b1;

// Second level of multiplexer
assign mux_in[0] = c ? mux1_out[0] : mux1_out[1];
assign mux_in[1] = c ? mux1_out[0] : 1'b0;
assign mux_in[2] = c ? mux2_out[0] : mux2_out[1];
assign mux_in[3] = c ? mux2_out[0] : d;

endmodule
