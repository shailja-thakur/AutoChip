module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	parameter OFF = 1'b0;
	parameter ON = 1'b1;

	// Define the current state
	reg curr_state, next_state;

	// Define the output
	reg out_reg;

	// Synchronous process for state update
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= OFF;
		end else begin
			curr_state <= next_state;
		end
	end

	// Next state logic
	always @(curr_state, j, k) begin
		case (curr_state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
			end
			default: next_state = OFF;
		endcase
	end

	// Output assignment
	always @(curr_state) begin
		case (curr_state)
			OFF: begin
				out_reg = 1'b0;
			end
			ON: begin
				out_reg = 1'b1;
			end
		endcase
	end

	// Assign output to module output
	assign out = out_reg;

endmodule
