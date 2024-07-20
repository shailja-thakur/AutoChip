module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// Define the state registers
	reg [1:0] state, next_state;
	
	// Initialize the state register
	always @(posedge clk or negedge aresetn) begin
		if (aresetn == 0) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Define the next state logic
	always @(state or x) begin
		case ({state, x})
			{S, 1'b0}: next_state = S;
			{S, 1'b1}: next_state = S1;
			{S1, 1'b0}: next_state = S10;
			{S1, 1'b1}: next_state = S1;
			{S10, 1'b0}: next_state = S;
			{S10, 1'b1}: next_state = S1;
			default: next_state = S; // Default state transition
		endcase
	end
	
	// Define the output logic
	always @(state) begin
		case (state)
			S, S1: z = 1'b0;
			S10: z = x;
		endcase
	end
	
endmodule
