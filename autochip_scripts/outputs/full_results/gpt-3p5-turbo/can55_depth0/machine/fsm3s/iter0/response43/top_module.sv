module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;
	
	// Define current state and next state
	state_t current_state, next_state;
	
	// Assign initial state
	assign current_state = A;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Assign next state based on current state and input
	always_comb begin
		// Default next state is current state
		next_state = current_state;
		
		case (current_state)
			A: begin
				if (in == 1'b1) begin
					next_state = B;
				end
			end
			B: begin
				if (in == 1'b0) begin
					next_state = C;
				end
			end
			C: begin
				if (in == 1'b1) begin
					next_state = D;
				end
			end
			D: begin
				if (in == 1'b0) begin
					next_state = C;
				end
			end
		endcase
	end
	
	// Assign output
	assign out = (current_state == D) ? 1'b1 : 1'b0;
	
endmodule
