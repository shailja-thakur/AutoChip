module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	typedef enum logic [3:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;

	// Declare registers
	reg state_type current_state;
	reg state_type next_state;

	// Assign initial state
	initial begin
		current_state <= S;
	end

	// Assign next state and output based on current state and input data
	always @(posedge clk) begin
		if (reset) begin
			current_state <= S;
		end else begin
			case (current_state)
				S:
					if (data) begin
						next_state <= S1;
					end else begin
						next_state <= S;
					end
				S1:
					if (data) begin
						next_state <= S11;
					end else begin
						next_state <= S;
					end
				S11:
					if (data) begin
						next_state <= S11;
					end else begin
						next_state <= S110;
					end
				S110:
					if (data) begin
						next_state <= Done;
					end else begin
						next_state <= S;
					end
				Done:
					next_state <= Done;
			endcase
			current_state <= next_state;
		end
	end

	// Assign output based on current state
	assign start_shifting = (current_state == Done);

endmodule
