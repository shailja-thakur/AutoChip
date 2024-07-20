module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	// Define the states
	typedef enum logic [1:0] {
		State0,
		State1,
		State2
	} state_type;
	
	// Define the state register and initialize it to State0
	reg state_type current_state = State0;
	
	// Define the next state variable
	wire state_type next_state;
	
	// Implement the state transition logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			current_state <= State0;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Implement the next state logic and output generation
	always_comb begin
		case (current_state)
			State0: begin
				if (x == 1'b1) begin
					next_state = State1;
				end else begin
					next_state = State0;
				end
				z = 1'b0;
			end
			
			State1: begin
				if (x == 1'b0) begin
					next_state = State2;
				end else begin
					next_state = State0;
				end
				z = 1'b0;
			end
			
			State2: begin
				if (x == 1'b1) begin
					next_state = State1;
				end else begin
					next_state = State0;
				end
				z = 1'b1;
			end
			
			default: begin
				next_state = State0;
				z = 1'b0;
			end
		endcase
	end
	
endmodule
