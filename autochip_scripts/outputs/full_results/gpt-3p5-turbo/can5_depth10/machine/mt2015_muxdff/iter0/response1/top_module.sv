module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Registers declaration
	reg Q_reg;

	// Always block triggered on the rising edge of the clock signal
	always @(posedge clk)
	begin
		// Evaluate the select signal
		if (L == 1'b1)
			Q_reg <= r_in; // Set output register to r_in value
		else
			Q_reg <= q_in; // Set output register to q_in value
	end

	// Assign the value of Q_reg to the output Q
	assign Q = Q_reg;

endmodule
