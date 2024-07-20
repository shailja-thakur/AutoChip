module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	// Declare state variable
	reg [1:0] state;
	
	// Declare next state variable
	reg [1:0] next_state;
	
	// Initialize state variable to walking left
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
		end else begin
			state <= next_state;
		end
	end
	
	// Declare output variables
	assign walk_left = (state == 2'b00);
	assign walk_right = (state == 2'b01);
	assign aaah = (state == 2'b10);
	
	// Compute next state based on current state and inputs
	always @ (state or bump_left or bump_right or ground) begin
		case (state)
			2'b00: begin // Walking left state
				if (bump_right) begin
					next_state = 2'b01; // Switch direction to walking right
				end else if (ground == 0) begin
					next_state = 2'b10; // Fall state
				end else begin
					next_state = 2'b00; // Continue walking left
				end
			end
			2'b01: begin // Walking right state
				if (bump_left) begin
					next_state = 2'b00; // Switch direction to walking left
				end else if (ground == 0) begin
					next_state = 2'b10; // Fall state
				end else begin
					next_state = 2'b01; // Continue walking right
				end
			end
			2'b10: begin // Falling state
				if (ground == 1) begin
					if (state == 2'b00) begin
						next_state = 2'b00; // Walking left
					end else if (state == 2'b01) begin
						next_state = 2'b01; // Walking right
					end
				end else begin
					next_state = 2'b10; // Continue falling
				end
			end
		endcase
	end

endmodule
