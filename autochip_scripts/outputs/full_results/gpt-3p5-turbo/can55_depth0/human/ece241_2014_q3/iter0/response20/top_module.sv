module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab00, ab01, ab11, ab10; // intermediate wires to connect the inputs of the 4-to-1 mux

assign ab00 = ~c & ~d;
assign ab01 = c & ~d;
assign ab11 = c & d;
assign ab10 = ~c & d;

assign mux_in[0] = ab00;
assign mux_in[1] = ab01;
assign mux_in[2] = ab11;
assign mux_in[3] = ab10;

endmodule
