module top_module (
	input wire clock,
	input wire a,
	output reg p,
	output reg q
);

	// Registers to hold the values of p and q
	reg p_reg;
	reg q_reg;

	// Assign the values of p and q to the output ports
	assign p = p_reg;
	assign q = q_reg;

	// Always block triggered on the negative edge of the clock signal
	always @(negedge clock)
	begin
		q_reg <= a;
	end

	// Always block triggered on any change of the input signal a
	always @(a)
	begin
		if (clock)
			p_reg <= a;
	end

endmodule
