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

reg walk_left;
reg walk_right;
reg aaah;
reg digging;
reg [4:0] counter;
reg [1:0] state;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or negedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
		counter <= 5'b0;
	end else begin
		case (state)
			WALK_LEFT: begin
				if (bump_right) begin
					state <= WALK_RIGHT;
				end else if (bump_left) begin
					state <= WALK_LEFT;
				end else if (ground == 0) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_LEFT;
				end
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
				digging <= 1'b0;
			end
			WALK_RIGHT: begin
				if (bump_left) begin
					state <= WALK_LEFT;
				end else if (bump_right) begin
					state <= WALK_RIGHT;
				end else if (ground == 0) begin
					state <= FALL;
				end else if (dig) begin
					state <= DIG;
				end else begin
					state <= WALK_RIGHT;
				end
				walk_left <= 1'b0;
				walk_right <= 1'b1;
				aaah <= 1'b0;
				digging <= 1'b0;
			end
			FALL: begin
				if (ground) begin
					state <= WALK_LEFT;
				end
				walk_left <= 1'b0;
				walk_right <= 1'b0;
				aaah <= 1'b1;
				digging <= 1'b0;
			end
			DIG: begin
				if (ground == 0) begin
					state <= FALL;
				end else if (counter >= 20) begin
					state <= WALK_LEFT;
				end
				walk_left <= 1'b0;
				walk_right <= 1'b0;
				aaah <= 1'b0;
				digging <= 1'b1;
			end
		endcase
		if (state == DIG) begin
			counter <= counter + 1;
		end else begin
			counter <= 5'b0;
		end
	end
end
endmodule
