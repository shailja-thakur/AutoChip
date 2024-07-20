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
	reg prev_ground;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
			prev_ground <= 1'b0;
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end
		else begin
			case(state)
				2'b00: begin // walking left
					if (bump_right && !bump_left && ground) begin
						state <= 2'b01; // switch directions
					end
					else if (ground == 1'b0) begin
						state <= 2'b10; // falling
					end
					else if (dig == 1'b1 && ground && !prev_ground) begin
						state <= 2'b11; // start digging
					end
				end
				2'b01: begin // walking right
					if (bump_left && !bump_right && ground) begin
						state <= 2'b00; // switch directions
					end
					else if (ground == 1'b0) begin
						state <= 2'b10; // falling
					end
					else if (dig == 1'b1 && ground && !prev_ground) begin
						state <= 2'b11; // start digging
					end
				end
				2'b10: begin // falling
					if (ground) begin
						state <= (walk_left) ? 2'b00 : 2'b01; // resume walking
					end
				end
				2'b11: begin // digging
					if (!ground) begin
						state <= 2'b10; // fall
					end
					else if (dig == 1'b0) begin
						state <= (walk_left) ? 2'b00 : 2'b01; // resume walking
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: begin // walking left
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
				digging <= 1'b0;
			end
			2'b01: begin // walking right
				walk_left <= 1'b0;
				walk_right <= 1'b1;
				aaah <= 1'b0;
				digging <= 1'b0;
			end
			2'b10: begin // falling
				walk_left <= 1'b0;
				walk_right <= 1'b0;
				aaah <= 1'b1;
				digging <= 1'b0;
			end
			2'b11: begin // digging
				walk_left <= 1'b0;
				walk_right <= 1'b0;
				aaah <= 1'b0;
				digging <= 1'b1;
			end
		endcase
	end
	
	always @(posedge clk) begin
		prev_ground <= ground;
	end
	
endmodule
