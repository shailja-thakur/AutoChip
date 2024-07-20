module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define state enumeration
	typedef enum logic [2:0] {S0, S1, S2, S3} state;
	
	// Define state register and next state variables
	state current_state;
	state next_state;
	
	// Define start shifting register
	reg start_shifting;
	
	// Initialize state register and start shifting register
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= S0;
			start_shifting <= 0;
		end
		else begin
			current_state <= next_state;
			start_shifting <= (current_state == S3);
		end
	end
	
	// Define next state logic
	always_comb begin
		case (current_state)
			S0: if (data) next_state = S1; else next_state = S0;
			S1: if (data) next_state = S2; else next_state = S0;
			S2: if (data) next_state = S3; else next_state = S0;
			S3: if (data) next_state = S3; else next_state = S0;
		endcase
	end

	// Assign start shifting output to output port
	assign start_shifting = start_shifting;

endmodule
