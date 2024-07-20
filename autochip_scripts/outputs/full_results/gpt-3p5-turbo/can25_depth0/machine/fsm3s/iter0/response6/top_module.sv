module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define 4 states using an enum
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} states_t;

	// Define state and next_state variables
	reg states_t state, next_state;

	// Initialize state to A
	initial begin
		state = A;
	end

	// Sequential logic
	always @(posedge clk) begin
		// Check reset condition
		if (reset) begin
			state <= A;
		end
		else begin
			// Assign next_state based on current state and input
			case (state)
				A: begin
					if (in) begin
						next_state <= B;
					end
					else begin
						next_state <= A;
					end
				end
				B: begin
					if (in) begin
						next_state <= B;
					end
					else begin
						next_state <= C;
					end
				end
				C: begin
					if (in) begin
						next_state <= D;
					end
					else begin
						next_state <= A;
					end
				end
				D: begin
					if (in) begin
						next_state <= B;
					end
					else begin
						next_state <= C;
					end
				end
			endcase
		end
	end

	// Combinational logic
	always @* begin
		// Assign output based on current state
		case (state)
			D: out = 1;
			default: out = 0;
		endcase
	end

	// Assign next_state to state at the end of the clock cycle
	always @(posedge clk) begin
		state <= next_state;
	end

endmodule
