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

	// Define states
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL = 2'b10;
	parameter DIG = 2'b11;

	// Define state outputs
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALL);
	assign digging = (state == DIG);

	// Define state transitions and outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case (state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
					end else if (!ground) begin
						state <= FALL;
					end else if (dig) begin
						state <= DIG;
					end
				end

				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
					end else if (!ground) begin
						state <= FALL;
					end else if (dig) begin
						state <= DIG;
					end
				end

				FALL: begin
					if (ground) begin
						state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
					end else if (dig) begin
						state <= DIG;
					end
				end

				DIG: begin
					if (!ground) begin
						state <= FALL;
					end else if (!dig) begin
						state <= (state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
					end
				end
			endcase
		end
	end
endmodule
