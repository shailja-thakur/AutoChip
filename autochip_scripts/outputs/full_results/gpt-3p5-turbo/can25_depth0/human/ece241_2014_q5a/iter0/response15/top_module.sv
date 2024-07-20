module top_module (
	input clk,
	input areset,
	input x,
	output reg z // Output should be a registered output
);
	reg [3:0] state; // State register
	reg [3:0] next_state; // Next state register

	always @(posedge clk or posedge areset) begin
		if (areset) begin // Asynchronous reset
			state <= 0; // Reset to initial state
		end else begin
			state <= next_state; // Update state to next state
		end
	end

	always @(state, x) begin
		case (state)
			0: begin // Initial state
				if (x == 1'b1) begin
					next_state <= 2; // Transition to state 2
				end else begin
					next_state <= 0; // Stay in state 0
				end
			end
			2: begin // State for input bit 0
				if (x == 1'b1) begin
					next_state <= 3; // Transition to state 3
				end else begin
					next_state <= 2; // Stay in state 2
				end
			end
			3: begin // State for input bit 1
				if (x == 1'b1) begin
					next_state <= 3; // Stay in state 3
				end else begin
					next_state <= 4; // Transition to state 4
				end
			end
			4: begin // State for input bit 2
				if (x == 1'b1) begin
					next_state <= 4; // Stay in state 4
				end else begin
					next_state <= 5; // Transition to state 5
				end
			end
			5: begin // State for input bit 3
				next_state <= 5; // Stay in state 5
			end
			default: next_state <= 0; // Default case, transition back to state 0
		endcase
	end

	always @(state) begin
		case (state)
			0: begin // Initial state
				z <= 1'b0; // Output is 0
			end
			2: begin // State for input bit 0
				z <= ~x; // Output is the complement of the input
			end
			3: begin // State for input bit 1
				z <= ~x; // Output is the complement of the input
			end
			4: begin // State for input bit 2
				z <= ~x; // Output is the complement of the input
			end
			5: begin // State for input bit 3
				z <= ~x; // Output is the complement of the input
			end
			default: z <= 1'b0; // Default case, output 0
		endcase
	end
endmodule
