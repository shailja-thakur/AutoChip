module top_module (
	input a,
	input b,
	input sel,
	output out
);

/* Declare internal wire */
wire mux_output;

/* Create 2-to-1 multiplexer */
assign mux_output = (sel) ? b : a;

/* Assign output */
assign out = mux_output;

endmodule
