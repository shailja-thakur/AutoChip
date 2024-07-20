module top_module (
	input a,
	input b,
	input sel,
	output out
);
	// define internal signals
	wire mux_out;
	
	// define the multiplexer
	assign mux_out = (sel == 1'b1) ? b : a;
	
	// assign the output
	assign out = mux_out;
endmodule
