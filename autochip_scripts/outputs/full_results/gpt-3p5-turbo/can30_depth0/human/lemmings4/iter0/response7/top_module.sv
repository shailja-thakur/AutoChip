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
	
	reg [4:0] state;

	parameter WALK_LEFT = 5'b00001;
	parameter WALK_RIGHT = 5'b00010;
	parameter FALL = 5'b00100;
	parameter DIG = 5'b01000;
	parameter SPLATTER = 5'b10000;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			case(state)
				WALK_LEFT: begin
					if (bump_right) begin
						state <= WALK_RIGHT;
					end else if (!ground) begin
						state <= FALL;
					end else if (dig) begin
						state <= DIG;
					end else begin
						state <= WALK_LEFT;
					end
				end
				
				WALK_RIGHT: begin
					if (bump_left) begin
						state <= WALK_LEFT;
					end else if (!ground) begin
						state <= FALL;
					end else if (dig) begin
						state <= DIG;
					end else begin
						state <= WALK_RIGHT;
					end
				end
				
				FALL: begin
					if (ground) begin
						state <= WALK_LEFT;
					end else if (dig) begin
						state <= DIG;
					end else if ((state == FALL) && (state_count >= 20)) begin
						state <= SPLATTER;
					end else begin
						state <= FALL;
					end
				end
				
				DIG: begin
					if (!ground) begin
						state <= FALL;
					end else if (digging && !ground) begin
						state <= FALL;
					end else if (state == DIG && ground) begin
						state <= WALK_LEFT;
					end else begin
						state <= DIG;
					end
				end
				
				SPLATTER: begin
					state <= SPLATTER;
				end
			endcase
		end
	end

	always @(state) begin
		case(state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			
			FALL: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			
			DIG: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
