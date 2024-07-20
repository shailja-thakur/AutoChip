module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	reg [24:0] a_temp; // Temporary variable to store generated vector for a
	reg [24:0] b_temp; // Temporary variable to store generated vector for b
	reg [24:0] c_temp; // Temporary variable to store generated vector for c
	reg [24:0] d_temp; // Temporary variable to store generated vector for d
	reg [24:0] e_temp; // Temporary variable to store generated vector for e

	// Generate the vector for a
	always @(a) begin
		if(a) // If a is 1, generate vector with value 0
			a_temp <= 25'b00000_00000_00000_00000_00000;
		else // If a is 0, generate vector with value 1
			a_temp <= 25'b11111_11111_11111_11111_11111;
	end

	// Generate the vector for b
	always @(b) begin
		if(b) // If b is 1, generate vector with value 0
			b_temp <= 25'b00000_00000_00000_00000_00000;
		else // If b is 0, generate vector with value 1
			b_temp <= 25'b11111_11111_11111_11111_11111;
	end

	// Generate the vector for c
	always @(c) begin
		if(c) // If c is 1, generate vector with value 0
			c_temp <= 25'b00000_00000_00000_00000_00000;
		else // If c is 0, generate vector with value 1
			c_temp <= 25'b11111_11111_11111_11111_11111;
	end

	// Generate the vector for d
	always @(d) begin
		if(d) // If d is 1, generate vector with value 0
			d_temp <= 25'b00000_00000_00000_00000_00000;
		else // If d is 0, generate vector with value 1
			d_temp <= 25'b11111_11111_11111_11111_11111;
	end

	// Generate the vector for e
	always @(e) begin
		if(e) // If e is 1, generate vector with value 0
			e_temp <= 25'b00000_00000_00000_00000_00000;
		else // If e is 0, generate vector with value 1
			e_temp <= 25'b11111_11111_11111_11111_11111;
	end

	// Compute the bitwise exclusive-or of the two vectors
	assign out = a_temp ^ {5{a}} | b_temp ^ {5{b}} | c_temp ^ {5{c}} | d_temp ^ {5{d}} | e_temp ^ {5{e}};

endmodule
