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

	reg [1:0] state, next_state;

	// Assign initial state
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= next_state;
	end

	// Assign next state based on input
	always @(*) begin
		case (state)
			S: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
			end

			S1: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S10;
			end

			S10: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
			end
		endcase
	end

	// Assign output based on state
	always @(state) begin
		case (state)
			S: z = 0;
			S1: z = 0;
			S10: z = x;
		endcase
	end

endmodule
