module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [1:0] ab; // multiplexer selector inputs

// Karnaugh map truth table
assign mux_in[0] = (c & !d) | (c & !ab[1]);
assign mux_in[1] = c & d & !ab;
assign mux_in[2] = (c & !ab[1]) | (c & d);
assign mux_in[3] = (c & d & ab[1]) | (!c & d) | (c & !d & ab);

assign ab[0] = a;
assign ab[1] = b;

endmodule
