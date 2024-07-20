module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// Define states
	typedef enum logic [2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;

	// Declare state and next_state variables
	reg [2:0] state;
	reg [2:0] next_state;
	
	// Assign initial state
	always @(posedge reset)
	begin
		state <= S;
	end
	
	// Assign next_state based on current state and data input
	always @(*)
	begin
		case(state)
			S: begin
				if(data)
					next_state = S1;
				else
					next_state = S;
			end
			S1: begin
				if(data)
					next_state = S11;
				else
					next_state = S;
			end
			S11: begin
				if(data)
					next_state = S11;
				else
					next_state = S110;
			end
			S110: begin
				if(data)
					next_state = Done;
				else
					next_state = S;
			end
			Done: begin
				next_state = Done;
			end
		endcase
	end
	
	// Update state on rising edge of clk
	always @(posedge clk)
	begin
		state <= next_state;
	end
	
	// Assign output based on current state
	always @(*)
	begin
		if(state == Done)
			start_shifting = 1'b1;
		else
			start_shifting = 1'b0;
	end
endmodule
