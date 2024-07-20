module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

reg [1:0] state;
reg [1:0] next_state;

parameter [1:0]
	IDLE = 2'b00,
	LEFT = 2'b01,
	RIGHT = 2'b10;

always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= IDLE;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
	end else begin
		state <= next_state;
		case (state)
			IDLE:
				if (bump_left) begin
					next_state = RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
				end else if (bump_right) begin
					next_state = LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
				end else if (ground) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
				end else if (dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = IDLE;
				end
			LEFT:
				if (bump_right) begin
					next_state = RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					digging <= 1'b0;
				end else if (!ground) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
					digging <= 1'b0;
				end else if (dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = LEFT;
				end
			RIGHT:
				if (bump_left) begin
					next_state = LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					digging <= 1'b0;
				end else if (!ground) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
					digging <= 1'b0;
				end else if (dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = RIGHT;
				end
		endcase
	end
end

initial begin
	clk = 0;
	areset = 1;
	bump_left = 0;
	bump_right = 0;
	ground = 0;
	dig = 0;
	
	#10 areset = 0;
	#10 clk = 1;
	#10 clk = 0;
	
	#10 bump_left = 1;
	#10 bump_left = 0;
	
	#10 bump_right = 1;
	#10 bump_right = 0;
	
	#10 ground = 1;
	#10 ground = 0;
	
	#10 dig = 1;
	#10 dig = 0;
	
	#10 areset = 1;
	#10 areset = 0;
	
	#20 $finish;
end

endmodule
