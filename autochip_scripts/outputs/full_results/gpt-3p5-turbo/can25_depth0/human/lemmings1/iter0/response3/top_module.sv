module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	// Declare state and output variables
	reg [1:0] state;
	reg walk_left;
	reg walk_right;
	
	// Define state encoding
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	
	// Define state transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
					end else if (bump_left) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
					end
				end
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
					end else if (bump_right) begin
						state <= WALK_RIGHT;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
					end
				end
			endcase
		end
	end
endmodule
