module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states as parameters
	parameter A = 1'b0, B = 1'b1;
	
	// State register
	reg state, next_state;

	// Sequential logic for state transitions
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset to state A
			state <= A;
		end else begin
			// State transition
			state <= next_state;
		end
	end

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				next_state = B; // Remain in state B
			end
			default: begin
				next_state = A; // Default state
			end
		endcase
	end

	// Combinational logic for output z
	always @(*) begin
		case (state)
			A: begin
				if (x) begin
					z = 1'b1;
				end else begin
					z = 1'b0;
				end
			end
			B: begin
				if (!x) begin
					z = 1'b1;
				end else begin
					z = 1'b0;
				end
			end
			default: begin
				z = 1'b0; // Default output
			end
		endcase
	end

endmodule
