module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);
	// State declaration
	reg [1:0] state;
	
	// Output declaration
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;
	
	// Default values
	assign walk_left = 1'b0;
	assign walk_right = 1'b0;
	assign aaah = 1'b0;
	assign digging = 1'b0;
	
	// Next state logic and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // Walking left
		end else begin
			case (state)
				2'b00: begin // Walking right
					if (bump_left && !bump_right) begin
						state <= 2'b01; // Switch to walking left
					end else if (!bump_left && bump_right) begin
						state <= 2'b00; // Continue walking right
					end else if (ground) begin
						state <= 2'b00; // Continue walking right
					end else begin
						state <= 2'b10; // Falling
					end
				end
				
				2'b01: begin // Walking left
					if (bump_left && !bump_right) begin
						state <= 2'b00; // Continue walking left
					end else if (!bump_left && bump_right) begin
						state <= 2'b01; // Continue walking left
					end else if (ground) begin
						state <= 2'b01; // Continue walking left
					end else begin
						state <= 2'b10; // Falling
					end
				end
				
				default: begin // Falling
					if (ground) begin
						if (state == 2'b10) begin
							if (walk_left) begin
								state <= 2'b01; // Falling left - change to walking left
							end else begin
								state <= 2'b00; // Falling right - change to walking right
							end
						end else begin
							state <= 2'b00; // Continue walking left
						end
					end else begin
						state <= 2'b10; // Continue falling
					end
				end
			endcase
		end
	end
	
	// Output assignments
	always @(state, bump_left, bump_right, ground, dig) begin
		walk_left = (state == 2'b01);
		walk_right = (state == 2'b00);
		aaah = (state == 2'b10);
		digging = ((state == 2'b01) || (state == 2'b00)) && (ground && !dig);
	end
endmodule
