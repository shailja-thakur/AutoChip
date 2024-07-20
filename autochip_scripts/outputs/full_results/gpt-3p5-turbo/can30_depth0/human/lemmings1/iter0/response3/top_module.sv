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

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b10; //reset state to walk_left
	end else begin
		case(state)
			2'b10: begin //state walk_left
				if (bump_right)
					state <= 2'b01; //switch to state walk_right if bumped on right
				else if (bump_left)
					state <= 2'b00; //stay in state walk_left if bumped on left
			end
			2'b01: begin //state walk_right
				if (bump_left)
					state <= 2'b00; //switch to state walk_left if bumped on left
				else if (bump_right)
					state <= 2'b01; //stay in state walk_right if bumped on right
			end
			default: begin //other states, should not occur
				state <= 2'b10; //reset state to walk_left
			end
		endcase
	end

	case(state)
		2'b10: begin //state walk_left
			walk_left = 1;
			walk_right = 0;
		end
		2'b01: begin //state walk_right
			walk_left = 0;
			walk_right = 1;
		end
		default: begin //other states, should not occur
			walk_left = 1;
			walk_right = 0;
		end
	endcase

end

endmodule
