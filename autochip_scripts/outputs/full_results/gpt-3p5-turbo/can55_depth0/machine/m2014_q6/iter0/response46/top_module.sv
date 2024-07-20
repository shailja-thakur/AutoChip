module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	// Define the states
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_t;
	
	// Define the current and next state variables
	state_t current_state;
	state_t next_state;
	
	// Output z and its internal signal
	reg z;
	wire z_internal;
	
	// Assign output z
	assign z = z_internal;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset to state A
			current_state <= A;
		end else begin
			// Update the current state to the next state
			current_state <= next_state;
		end
	end
	
	// Combinational logic
	always @(*) begin
		case (current_state)
			A: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			B: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			D: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = F;
				end
			end
			E: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			F: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
		endcase
		
		// Update internal signal z_internal
		if (current_state == E || current_state == F) begin
			z_internal = 1'b1;
		end else begin
			z_internal = 1'b0;
		end
	end
	
endmodule
