module top_module (
	input a,
	input b,
	input sel,
	output out
);

    // Declare wire to connect to output
    wire mux_out;

    // Multiplexer logic
    assign mux_out = (sel == 1'b1) ? b : a;

    // Output assignment
    assign out = mux_out;
    
endmodule
