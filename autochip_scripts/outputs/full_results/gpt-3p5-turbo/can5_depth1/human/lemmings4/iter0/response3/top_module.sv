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
	parameter IDLE = 2'b00;
	parameter WALKING_LEFT = 2'b01;
	parameter WALKING_RIGHT = 2'b10;
	
	reg [1:0] state, next_state;
	reg splatter;
	reg [4:0] fall_count;
	
	always @(posedge clk or posedge areset) begin
		if(areset)
			state <= WALKING_LEFT;
		else
			state <= next_state;
	end
	
	always @(*) begin
		next_state = state;
		splatter = 0;
		
		case(state)
			IDLE: begin
				if(ground == 0)
					next_state = WALKING_LEFT;
			end
			
			WALKING_LEFT: begin
				if(bump_left == 1)
					next_state = WALKING_RIGHT;
				else if(bump_right == 1)
					next_state = WALKING_LEFT;
				else if(dig == 1 && ground == 1)
					next_state = WALKING_LEFT;
				else if(ground == 0)
					next_state = IDLE;
				
				if(fall_count >= 20 && ground == 1)
					splatter = 1;
			end
			
			WALKING_RIGHT: begin
				if(bump_left == 1)
					next_state = WALKING_LEFT;
				else if(bump_right == 1)
					next_state = WALKING_RIGHT;
				else if(dig == 1 && ground == 1)
					next_state = WALKING_RIGHT;
				else if(ground == 0)
					next_state = IDLE;
				
				if(fall_count >= 20 && ground == 1)
					splatter = 1;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if(areset == 1)
			fall_count <= 0;
		else if((state == WALKING_LEFT || state == WALKING_RIGHT) && ground == 0 && fall_count < 20)
			fall_count <= fall_count + 1;
		else
			fall_count <= 0;
	end
	
	always @(state, splatter) begin
		case(state)
			IDLE: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			
			WALKING_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			
			WALKING_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
		endcase
		
		if(splatter == 1) begin
			walk_left = 0;
			walk_right = 0;
			aaah = 0;
			digging = 0;
		end
	end
endmodule
