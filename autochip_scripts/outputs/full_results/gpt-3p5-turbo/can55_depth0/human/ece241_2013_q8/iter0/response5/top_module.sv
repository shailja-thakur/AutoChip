module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define the states
	enum logic [1:0] state;
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	// Define the next state and output logic
	logic [1:0] next_state;
	logic next_output;
	
	// Initial state and output assignment
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	always_comb begin
		case (state)
			S0: begin
				next_state = x ? S1 : S0;
				next_output = 0;
			end
			S1: begin
				next_state = x ? S1 : S2;
				next_output = 0;
			end
			S2: begin
				next_state = x ? S1 : S0;
				next_output = x ? 1 : 0;
			end
			default: begin
				next_state = S0;
				next_output = 0;
			end
		endcase
	end
	
	// Output assignment
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			z <= 0;
		else
			z <= next_output;
	end
endmodule
