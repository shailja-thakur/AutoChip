module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare intermediate wire1
	wire wire1;
	// Declare intermediate wire2
	wire wire2;
	
	// First layer - AND gates
	and #(.N(1)) and1 (.in({a, b}), .out(wire1));
	and #(.N(1)) and2 (.in({c, d}), .out(wire2));

	// Second layer - OR gate
	or #(.N(1)) or1 (.in({wire1, wire2}), .out(out));

	// Inverter
	not #(.N(1)) not1 (.in(out), .out(out_n));

endmodule
