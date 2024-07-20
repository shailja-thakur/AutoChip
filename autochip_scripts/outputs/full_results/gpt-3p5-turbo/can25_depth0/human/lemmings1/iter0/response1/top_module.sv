module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

	// Define states and signals
	reg [1:0] state;
	wire [1:0] next_state;
	wire output;

	// Initialization
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b10; // Initial state: walking left
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic
	always @* begin
		next_state = 2'b00; // Default: stay in the same state
		output = 0; // Default: don't change walking direction

		case (state)
			2'b00: begin // walking left state
				if (bump_right) begin // if bumped on right, switch direction
					next_state = 2'b01;
					output = 1; // walking right
				end
			end
			2'b01: begin // walking right state
				if (bump_left) begin // if bumped on left, switch direction
					next_state = 2'b00;
					output = 1; // walking left
				end
			end
			default: begin
				// Invalid state, should not be reached
				$display("Error: Invalid state");
			end
		endcase
	end

	// Output assignments
	assign walk_left = (state == 2'b00);
	assign walk_right = (state == 2'b01);
endmodule
