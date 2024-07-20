module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// Define the states
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_type;
	
	// Declare the internal signals
	state_type current_state, next_state;
	
	// Assign the initial state
	assign current_state = A;
	
	// Generate the next state based on current state and input w
	always @(posedge clk) begin
		if (reset) begin
			next_state <= A;
		end else begin
			case (current_state)
				A: begin
					if (w == 1'b0) begin
						next_state <= B;
					end else begin
						next_state <= A;
					end
				end
				B: begin
					if (w == 1'b1) begin
						next_state <= D;
					end else begin
						next_state <= C;
					end
				end
				C: begin
					if (w == 1'b1) begin
						next_state <= D;
					end else begin
						next_state <= E;
					end
				end
				D: begin
					if (w == 1'b1) begin
						next_state <= A;
					end else begin
						next_state <= F;
					end
				end
				E: begin
					if (w == 1'b1) begin
						next_state <= D;
					end else begin
						next_state <= E;
					end
				end
				F: begin
					if (w == 1'b1) begin
						next_state <= D;
					end else begin
						next_state <= C;
					end
				end
				default: next_state <= A;
			endcase
		end
	end
	
	// Update the current state with the next state
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Output z based on the current state
	assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
	
endmodule
