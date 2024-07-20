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

// Define states
parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;

// Define state update logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= LEFT;
	end else begin
		case(state)
			LEFT: begin
				if (bump_right && !bump_left) begin
					state <= RIGHT;
				end
			end
			RIGHT: begin
				if (bump_left && !bump_right) begin
					state <= LEFT;
				end
			end
		endcase
	end
end

// Define output logic
always @(state) begin
	case(state)
		LEFT: begin
			walk_left = 1;
			walk_right = 0;
		end
		RIGHT: begin
			walk_left = 0;
			walk_right = 1;
		end
	endcase
end

endmodule
