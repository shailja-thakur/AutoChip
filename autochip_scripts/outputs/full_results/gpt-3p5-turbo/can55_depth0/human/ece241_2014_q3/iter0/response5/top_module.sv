module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Inputs
	input a;
	input b;
	
	// Internal wires
	wire[1:0] ab;
	wire[3:0] k_map_outputs;
	
	// Assign the values for ab based on the values of a and b
	assign ab[0] = ~a & ~b;
	assign ab[1] = ~a & b;
	
	// Implementing the Karnaugh map in a case statement
	always @* begin
		case ({c, d})
			2'b00: k_map_outputs = 4'b0001;
			2'b01: k_map_outputs = 4'b1000;
			2'b11: k_map_outputs = 4'b1011;
			2'b10: k_map_outputs = 4'b1001;
			default: k_map_outputs = 4'bxxxx; // For any other input combination not specified in the Karnaugh map
		endcase
	end
	
	// Connecting the output of the Karnaugh map to the mux inputs
	assign mux_in = k_map_outputs;

endmodule
