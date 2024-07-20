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
	// Define states
	parameter IDLE = 2'b00;
	parameter WALK_LEFT = 2'b01;
	parameter WALK_RIGHT = 2'b10;
	
	// Define output assignments
	assign walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
	assign walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;
	assign aaah = (state == IDLE && falling) ? 1'b1 : 1'b0;
	assign digging = (state == WALK_LEFT || state == WALK_RIGHT) ? 1'b1 : 1'b0;
	
	// Define state and next state variables
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Define internal variables
	reg falling;
	reg [4:0] fall_counter;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			falling <= 1'b0;
			fall_counter <= 5'b0;
		end
		else begin
			state <= next_state;
			falling <= (state == IDLE && ground == 1'b0) ? 1'b1 : 1'b0;
			
			case (state)
				WALK_LEFT: begin
					if (bump_right || (bump_left && bump_right)) begin
						next_state <= WALK_RIGHT;
					end
					else if (!ground && !falling && dig) begin
						next_state <= IDLE;
					end
					else if (falling) begin
						next_state <= IDLE;
					end
					else begin
						next_state <= WALK_LEFT;
					end
				end
				
				WALK_RIGHT: begin
					if (bump_left || (bump_left && bump_right)) begin
						next_state <= WALK_LEFT;
					end
					else if (!ground && !falling && dig) begin
						next_state <= IDLE;
					end
					else if (falling) begin
						next_state <= IDLE;
					end
					else begin
						next_state <= WALK_RIGHT;
					end
				end
				
				IDLE: begin
					if (fall_counter >= 5'd20 && ground) begin
						next_state <= IDLE;
					end
					else if (!ground) begin
						next_state <= IDLE;
					end
					else if (!falling) begin
						if (bump_left && bump_right) begin
							next_state <= next_state;
						end
						else if (bump_left) begin
							next_state <= WALK_RIGHT;
						end
						else if (bump_right) begin
							next_state <= WALK_LEFT;
						end
						else if (dig) begin
							next_state <= IDLE;
						end
						else begin
							next_state <= next_state;
						end
					end
					else begin
						next_state <= next_state;
					end
				end
			endcase
		end
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			fall_counter <= 5'b0;
		end
		else begin
			if (state == IDLE && ground == 1'b0) begin
				fall_counter <= fall_counter + 5'b1;
			end
			else begin
				fall_counter <= 5'b0;
			end
		end
	end
endmodule
