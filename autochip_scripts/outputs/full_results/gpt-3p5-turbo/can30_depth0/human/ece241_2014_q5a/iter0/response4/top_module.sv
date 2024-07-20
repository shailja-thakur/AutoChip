module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define state 
	reg [2:0] state;

	// Define output
	wire z;

	// Define local wires and regs
	reg x_prev; // previous input value

	// Define state parameters
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;

	// Define state transition conditions
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state to initial state S0
			state <= S0;
		end else begin
			// State transitions 
			case(state)
				S0: begin
					if (x_prev == 1'b0 && x == 1'b1) begin
						state <= S1;
					end
				end
				S1: begin
					if (x_prev == 1'b1 && x == 1'b0) begin
						state <= S2;
					end
				end
				S2: begin
					if (x_prev == 1'b0 && x == 1'b1) begin
						state <= S1;
					end
				end
			endcase
		end
	end

	// Define output values based on state
	always @(state, x) begin
		case(state)
			S0: begin
				// Output is same as input
				z = x;
			end
			S1, S2: begin
				// Output is 2's complement of input
				z = ~x + 1'b1;
			end
		endcase
	end

	// Store current input for next cycle comparison
	always @(posedge clk) begin
		x_prev <= x;
	end

endmodule
