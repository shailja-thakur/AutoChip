module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// State definition
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

reg [1:0] state;	// State register

always @(posedge clk or negedge aresetn) begin
	if (~aresetn)
		state <= S0;	// Reset to initial state
	else begin
		case(state)
			S0: begin
				if (x)	// Transition to next state S1 if input is high
					state <= S1;
				else
					state <= S0;	// Stay in the same state
			end
			S1: begin
				if (x)	// Transition to next state S2 if input is high
					state <= S2;
				else
					state <= S0;	// Return to initial state
			end
			S2: begin
				if (x)	// Transition to next state S2 if input is high
					state <= S2;
				else
					state <= S0;	// Return to initial state
			end
		endcase
	end
end

always @(posedge clk or negedge aresetn) begin
	// Output logic-1 when "101" sequence is detected
	if (~aresetn)
		z <= 0;
	else begin
		if (state == S2)
			z <= 1;
		else
			z <= 0;
	end
end

endmodule
