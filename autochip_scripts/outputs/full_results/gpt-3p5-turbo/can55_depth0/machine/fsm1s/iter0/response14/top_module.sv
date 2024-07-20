module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Parameterized register to store the current state
	reg [1:0] state;

	// Combinational logic block to determine the next state
	always @ (state, in)
	begin
		if (state == 2'b00) // current state is A
		begin
			if (in) // in input is high
				state <= 2'b00; // next state is A
			else
				state <= 2'b01; // next state is B
		end
		else // current state is B
		begin
			if (in) // in input is high
				state <= 2'b01; // next state is B
			else
				state <= 2'b00; // next state is A
		end
	end

	// Always block triggered on the rising edge of the clk input
	always @ (posedge clk)
	begin
		if (reset) // reset input is high
			state <= 2'b01; // reset to initial state B
		else
			state <= state; // update state with next state
	end

	// Assign the value of the state register to the out output
	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // If state is B, out is high, otherwise out is low

endmodule
