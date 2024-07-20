module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Assign first bit of mux_in to logical OR of inputs c and d
assign mux_in[0] = c || d;

// Assign second bit of mux_in to 0
assign mux_in[1] = 0;

// Assign third bit of mux_in to logical NOT of input d
assign mux_in[2] = ~d;

// Assign fourth bit of mux_in to logical AND of inputs c and d
assign mux_in[3] = c && d;

endmodule
