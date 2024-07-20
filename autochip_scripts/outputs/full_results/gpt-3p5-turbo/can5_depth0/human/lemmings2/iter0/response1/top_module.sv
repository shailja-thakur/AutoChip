module top_module (    // Declaration of module top_module with input and output ports
	input clk,         // Clock signal
	input areset,      // Asynchronous reset signal
	input bump_left,   // Input signal for bump on the left
	input bump_right,  // Input signal for bump on the right
	input ground,      // Input signal for ground
	output walk_left,  // Output signal for walking left
	output walk_right, // Output signal for walking right
	output aaah        // Output signal for aaah
);

	reg [1:0] state;     // State register to hold the current state
	reg next_walk_left;  // Next state for walking left
	reg next_walk_right; // Next state for walking right

	// Moore state machine states
	parameter LEFT = 2'b00;
	parameter RIGHT = 2'b01;
	parameter FALLING = 2'b10;

	// Assign the initial state of the machine
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Assign the next state based on the current state and input signals
	always @(*) begin
		next_walk_left = 1'b0;
		next_walk_right = 1'b0;

		case (state)
			LEFT: begin
				if (bump_right) begin
					next_state = RIGHT;
				end else begin
					next_state = LEFT;
				end
			end
			RIGHT: begin
				if (bump_left) begin
					next_state = LEFT;
				end else begin
					next_state = RIGHT;
				end
			end
			FALLING: begin
				if (ground) begin
					if (state == LEFT) begin
						next_state = LEFT;
					end else begin
						next_state = RIGHT;
					end
				end else begin
					next_state = FALLING;
				end
			end
			default: next_state = LEFT;
		endcase
	end

	// Assign the output signals based on the current state
	always @(*) begin
		case (state)
			LEFT: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
			end
			RIGHT: begin
				walk_left = 1'b0;
				walk_right = 1'b1;
				aaah = 1'b0;
			end
			FALLING: begin
				walk_left = 1'b0;
				walk_right = 1'b0;
				aaah = 1'b1;
			end
			default: begin
				walk_left = 1'b1;
				walk_right = 1'b0;
				aaah = 1'b0;
			end
		endcase
	end

endmodule
