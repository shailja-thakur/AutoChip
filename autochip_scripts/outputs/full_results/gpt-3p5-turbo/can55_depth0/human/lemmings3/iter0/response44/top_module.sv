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

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Reset state to walk_left
		state <= 2'b00;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
	end else begin
		case (state)
			2'b00: begin // walk_left state
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
				
				// State transition conditions
				if (bump_right) begin
					state <= 2'b01; // switch to walk_right state
				end else if (!ground) begin
					state <= 2'b10; // switch to fall state
				end else if (dig) begin
					state <= 2'b11; // switch to digging state
				end
			end
			
			2'b01: begin // walk_right state
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
				
				// State transition conditions
				if (bump_left) begin
					state <= 2'b00; // switch to walk_left state
				end else if (!ground) begin
					state <= 2'b10; // switch to fall state
				end else if (dig) begin
					state <= 2'b11; // switch to digging state
				end
			end
			
			2'b10: begin // fall state
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
				
				// State transition conditions
				if (ground) begin
					if (state == 2'b00) begin
						state <= 2'b00; // switch to walk_left state
					end else if (state == 2'b01) begin
						state <= 2'b01; // switch to walk_right state
					end
				end
			end
			
			2'b11: begin // digging state
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
				
				// State transition conditions
				if (!ground) begin
					state <= 2'b10; // switch to fall state
				end
			end
		endcase
	end
end

endmodule
