module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// Define states
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;

// Define signals
reg [1:0] current_state;
reg [1:0] next_state;

// Initialize current state
always @(posedge clk, negedge aresetn) begin
	if (~aresetn)
		current_state <= S0;
	else
		current_state <= next_state;
end

// Determine next state and output
always @* begin
	case (current_state)
		S0: begin
			if (x == 1)
				next_state = S1;
			else
				next_state = S0;
			z = 0;
		end
		S1: begin
			if (x == 0)
				next_state = S2;
			else
				next_state = S1;
			z = 0;
		end
		S2: begin
			if (x == 1)
				next_state = S1;
			else
				next_state = S0;
			z = 1;
		end
		default: begin
			next_state = S0;
			z = 0;
		end
	endcase
end

endmodule
