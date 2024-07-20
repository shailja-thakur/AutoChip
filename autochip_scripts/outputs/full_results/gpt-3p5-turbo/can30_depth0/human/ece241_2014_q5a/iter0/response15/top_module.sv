module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Internal signals
	reg [7:0] count;  // Counter for number of bits
	reg [7:0] z_reg; // Register for storing the inverted bits
	reg [7:0] z;     // Output

	// State enumeration
	enum state_type {RESET, CONVERT}; // State types
	state_type current_state, next_state; // State variables

	// Reset state
	initial begin
		current_state = RESET;
		z_reg = 0;
		z = z_reg;
	end

	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= RESET;
			count <= 0;
			z_reg <= 0;
			z <= 0;
		end else begin
			current_state <= next_state;
			count <= count + 1;
			z_reg <= z_reg | (x << count);
			z <= ~z_reg + 1;
		end
	end

	// Next state logic
	always @(current_state, x) begin
		case (current_state)
			RESET: begin
				if (~areset) begin
					next_state = RESET;
				end else begin
					next_state = CONVERT;
				end
			end
			CONVERT: begin
				if (count == 7) begin
					next_state = RESET;
				end else begin
					next_state = CONVERT;
				end
			end
			default: next_state = RESET;
		endcase
	end

endmodule
