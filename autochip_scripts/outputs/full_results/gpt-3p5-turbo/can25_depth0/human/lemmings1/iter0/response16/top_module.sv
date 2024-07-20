module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);

reg [1:0] state;
reg walk_left;
reg walk_right;

// State machine
always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= 2'b10; // walking left state
	end else begin
		case(state)
			2'b00: begin // walking right state
				if(bump_left) begin
					state <= 2'b10; // walking left state
				end else if(bump_right) begin
					state <= 2'b00; // walking right state
				end
			end
			2'b10: begin // walking left state
				if(bump_left & bump_right) begin
					state <= 2'b00; // walking right state
				end else if(bump_right) begin
					state <= 2'b00; // walking right state
				end
			end
		endcase
	end
end

// Output logic
always @(state) begin
	case(state)
		2'b00: begin // walking right state
			walk_left = 1;
			walk_right = 0;
		end
		2'b10: begin // walking left state
			walk_left = 0;
			walk_right = 1;
		end
	endcase
end

endmodule
