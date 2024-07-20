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
	
	always @(posedge clk) begin
		if (areset) begin
			state <= 2'b01;  // Initialize state to 'walk_left' state
			walk_left <= 1'b1; // Start walking left
			walk_right <= 1'b0;
			aaah <= 1'b0;
		end else begin
			case (state)
				2'b00: begin  // 'fall' state
					if (ground) begin
						state <= 2'b01;
						walk_left <= bump_right;
						walk_right <= bump_left;
						aaah <= 1'b0;
					end
				end
				2'b01: begin  // 'walk_left' state
					if (bump_left) begin
						state <= 2'b10;
						walk_left <= 1'b0;
						walk_right <= 1'b1;				
					end else if (bump_right) begin
						state <= 2'b11;
						walk_left <= 1'b1;
						walk_right <= 1'b0;				
					end else if (dig) begin
						state <= 2'b00;
						walk_left <= 1'b1;
						walk_right <= 1'b0;
					end
				end
				2'b10: begin  // 'walk_right' state
					if (bump_right) begin
						state <= 2'b11;
						walk_left <= 1'b1;
						walk_right <= 1'b0;				
					end else if (dig) begin
						state <= 2'b00;
						walk_left <= 1'b1;
						walk_right <= 1'b0;				
					end else if (bump_left) begin
						state <= 2'b01;
						walk_left <= 1'b0;
						walk_right <= 1'b1;
					end
				end
				2'b11: begin  // 'dig' state
					if (ground) begin
						state <= 2'b01;
						walk_left <= bump_right;
						walk_right <= bump_left;
						aaah <= 1'b0;
					end
				end
			endcase
		end
	end
	
	assign aaah = (state == 2'b00);
	assign digging = (state == 2'b11);
	
endmodule
