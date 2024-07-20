module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state;
	
	// Define the state and next state signals
	reg state cur_state;
	reg state next_state;
	
	// Define the default state
	localparam state DEFAULT_STATE = S;
	
	// Initialize the state registers
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			cur_state <= DEFAULT_STATE;
		end else begin
			cur_state <= next_state;
		end
	end
	
	// Define the state transition and output logic
	always_comb begin
		case(cur_state)
			S: begin
				if (x == 0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
				z = 0;
			end
			
			S1: begin
				if (x == 0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
				z = 0;
			end
			
			S10: begin
				if (x == 0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
				z = x;
			end
			
			default: begin
				next_state = DEFAULT_STATE;
				z = 0;
			end
		endcase
	end
	
endmodule
