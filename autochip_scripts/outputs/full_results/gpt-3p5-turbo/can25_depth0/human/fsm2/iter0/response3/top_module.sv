module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	parameter OFF = 1'b0;
	parameter ON = 1'b1;

	// Define the state variable
	reg state;

	// Define the next state variable
	reg next_state;

	// Define the output variable
	wire out;

	// Asynchronous reset logic
	always @(posedge areset)
		if (areset)
			state <= OFF;

	// State transition logic
	always @(posedge clk) begin
		state <= next_state;
	end

	// Output logic
	assign out = (state == ON);

	// Next state and output logic
	always @(*) begin
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end

			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
		endcase
	end
endmodule
