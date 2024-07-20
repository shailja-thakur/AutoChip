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

reg [1:0] state;
parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;
parameter FALL = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= LEFT;
	end else begin
		case (state)
			LEFT: begin
				if (ground) begin
					if (bump_left && !bump_right) begin
						state <= RIGHT;
					end else if (!bump_left && bump_right) begin
						state <= LEFT;
					end else if (bump_left && bump_right) begin
						state <= RIGHT;
					end
				end else begin
					state <= FALL;
				end
			end
			RIGHT: begin
				if (ground) begin
					if (bump_left && !bump_right) begin
						state <= LEFT;
					end else if (!bump_left && bump_right) begin
						state <= RIGHT;
					end else if (bump_left && bump_right) begin
						state <= LEFT;
					end
				end else begin
					state <= FALL;
				end
			end
			FALL: begin
				if (ground) begin
					if (state == LEFT) begin
						state <= LEFT;
					end else if (state == RIGHT) begin
						state <= RIGHT;
					end
				end
			end
		endcase
	end
end

assign walk_left = (state == LEFT);
assign walk_right = (state == RIGHT);
assign aaah = (state == FALL);

endmodule
