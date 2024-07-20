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
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL = 2'b10;
	parameter DIG = 2'b11;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
					end else begin
						if (ground == 0) begin
							state <= FALL;
						end else begin
							state <= WALK_LEFT;
						end
					end
				end
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
					end else begin
						if (ground == 0) begin
							state <= FALL;
						end else begin
							state <= WALK_RIGHT;
						end
					end
				end
				FALL: begin
					if (ground) begin
						state <= state;
					end else begin
						state <= FALL;
					end
				end
				DIG: begin
					if (!ground || dig) begin
						state <= WALK_LEFT;
					end else begin
						state <= DIG;
					end
				end
				default: state <= WALK_LEFT;
			endcase
		end
	end

	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALL);
	assign digging = (state == DIG);

endmodule
