module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Parameterized register to store current state
	reg [1:0] state;

	// Combinational logic to determine next state
	always @(state, in)
	begin
		if (state == 2'b00) // State A
		begin
			if (in)
				state <= 2'b00; // Next state A
			else
				state <= 2'b01; // Next state B
		end
		else // State B
		begin
			if (in)
				state <= 2'b01; // Next state B
			else
				state <= 2'b00; // Next state A
		end
	end

	// Always block triggered on the rising edge of clk
	always @(posedge clk)
	begin
		if (reset)
			state <= 2'b01; // Reset to initial state B
		else
			state <= next_state; // Update state with the next state determined by the combinational logic block
	end

	// Assign the value of state to out output
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
