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
	reg walk_left_reg, walk_right_reg, aaah_reg, digging_reg;
	wire ground_falling;
	
	// Falling Counter
	reg [4:0] fall_counter;
	wire splatter_flag;
	
	// State: Walking Left
	localparam WALKING_LEFT = 4'b0001;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALKING_LEFT;
			walk_left_reg <= 1'b1;
			walk_right_reg <= 1'b0;
			aaah_reg <= 1'b0;
			digging_reg <= 1'b0;
			fall_counter <= 5'b00000;
		end else begin
			case (state)
				WALKING_LEFT: begin
					if (bump_right) begin
						state <= WALKING_RIGHT;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b1;
					end else if (fall_counter == 5'b10100) begin
						state <= WALKING_LEFT;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b0;
						fall_counter <= 5'b00000;
					end else if (dig && ground) begin
						state <= DIGGING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b1;
					end else if (~ground) begin
						state <= FALLING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b1;
						digging_reg <= 1'b0;
					end
				end
				
				// State: Walking Right
				WALKING_RIGHT: begin
					if (bump_left) begin
						state <= WALKING_LEFT;
						walk_left_reg <= 1'b1;
						walk_right_reg <= 1'b0;
					end else if (fall_counter == 5'b10100) begin
						state <= WALKING_RIGHT;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b0;
						fall_counter <= 5'b00000;
					end else if (dig && ground) begin
						state <= DIGGING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b1;
					end else if (~ground) begin
						state <= FALLING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b1;
						digging_reg <= 1'b0;
					end
				end
				
				// State: Falling
				FALLING: begin
					if (ground) begin
						if (fall_counter > 5'b01010) begin
							state <= WALKING_LEFT;
							walk_left_reg <= 1'b1;
							walk_right_reg <= 1'b0;
							aaah_reg <= 1'b0;
							digging_reg <= 1'b0;
							fall_counter <= 5'b00000;
						end else begin
							state <= WALKING_LEFT;
							walk_left_reg <= walk_left_reg;
							walk_right_reg <= walk_right_reg;
							aaah_reg <= 1'b0;
							digging_reg <= digging_reg;
						end
					end else if (fall_counter == 5'b10100) begin
						state <= FALLING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b0;
						fall_counter <= 5'b00000;
					end else if (dig && ground) begin
						state <= DIGGING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b1;
					end
				end
				
				// State: Digging
				DIGGING: begin
					if (~ground) begin
						state <= FALLING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b1;
						digging_reg <= 1'b0;
					end else if (fall_counter == 5'b10100) begin
						state <= DIGGING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b0;
						fall_counter <= 5'b00000;
					end else if (dig && ground) begin
						state <= DIGGING;
						walk_left_reg <= 1'b0;
						walk_right_reg <= 1'b0;
						aaah_reg <= 1'b0;
						digging_reg <= 1'b1;
					end
				end
				
				default: begin
					state <= WALKING_LEFT;
					walk_left_reg <= 1'b1;
					walk_right_reg <= 1'b0;
					aaah_reg <= 1'b0;
					digging_reg <= 1'b0;
					fall_counter <= 5'b00000;
				end
			endcase
		end
	end
	
	// Falling Counter
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			fall_counter <= 5'b00000;
		end else begin
			if (state == FALLING) begin
				fall_counter <= fall_counter + 1'b1;
			end else begin
				fall_counter <= 5'b00000;
			end
		end
	end
	
	// Splatter Flag
	assign splatter_flag = (fall_counter == 5'b10100) && ground;
	
	// Output Assignments
	assign walk_left = (splatter_flag) ? 1'b0 : walk_left_reg;
	assign walk_right = (splatter_flag) ? 1'b0 : walk_right_reg;
	assign aaah = (splatter_flag) ? 1'b0 : aaah_reg;
	assign digging = (splatter_flag) ? 1'b0 : digging_reg;
	
endmodule
