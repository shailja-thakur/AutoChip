module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	reg [1:0] state;
	reg [1:0] next_state;

	// Assign initial state
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= next_state;
	end

	// Assign next state based on input x and current state
	always @(state, x) begin
		case (state)
			S:
				if (x)
					next_state <= S1;
				else
					next_state <= S;
			S1:
				if (x)
					next_state <= S1;
				else
					next_state <= S10;
			S10:
				if (x)
					next_state <= S1;
				else
					next_state <= S;
		endcase
	end

	// Update output z based on current state
	always @(state, x) begin
		case (state)
			S, S1:
				z <= 0;
			S10:
				z <= x;
		endcase
	end

endmodule
