module top_module(
	input a, 
	input b,
	output out
);
	// Define internal wires
	wire or_output;
	wire not_output;
	
	// Instantiate OR gate
	or_gate or1(.a(a), .b(b), .out(or_output));
	
 	// Instantiate inverter
 	not_gate not1(.a(or_output), .out(not_output));

  	// Assign output
  	assign out = not_output;
  
endmodule
