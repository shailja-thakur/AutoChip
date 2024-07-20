module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	parameter [1:0] S0 = 2'b00;
	parameter [1:0] S1 = 2'b01;
	parameter [1:0] S2 = 2'b10;

	// Define the state variable
	reg [1:0] state;

	// Define the next state variable
	reg [1:0] next_state;

	// Define the output signal assignment
	always @(state, x) begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S2;
				else
					next_state = S0;
			end
			S2: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
		endcase
	end

	// Define the synchronous reset
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Define the output signal assignment
	always @(state) begin
		if (state == S2)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

endmodule
