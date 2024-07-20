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

	// State declaration
	reg [4:0] state;
	
	// State parameter declaration
	parameter [4:0]
		WALK_LEFT = 5'b00001,
		WALK_RIGHT = 5'b00010,
		FALL = 5'b00100,
		DIG = 5'b01000,
		SPLATTER = 5'b10000;
		
	// Counters
	reg [4:0] fall_counter;
	reg [4:0] dig_counter;
	
	// Outputs
	walk_left = (state == WALK_LEFT);
	walk_right = (state == WALK_RIGHT);
	aaah = (state == FALL);
	digging = (state == DIG);

	// State transition logic
	always @(posedge clk) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_counter <= 0;
			dig_counter <= 0;
		end else begin
			case (state)
				WALK_LEFT:
					if (bump_right) begin
						state <= WALK_RIGHT;
						fall_counter <= 0;
						dig_counter <= 0;
					end else if (ground == 0) begin
						state <= FALL;
						fall_counter <= 0;
						dig_counter <= 0;
					end else if (dig) begin
						state <= DIG;
						fall_counter <= 0;
						dig_counter <= 0;
					end
				WALK_RIGHT:
					if (bump_left) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
						dig_counter <= 0;
					end else if (ground == 0) begin
						state <= FALL;
						fall_counter <= 0;
						dig_counter <= 0;
					end else if (dig) begin
						state <= DIG;
						fall_counter <= 0;
						dig_counter <= 0;
					end
				FALL:
					if (ground) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
						dig_counter <= 0;
					end else if (fall_counter == 20) begin
						state <= SPLATTER;
						fall_counter <= 0;
						dig_counter <= 0;
					end
				DIG:
					if (ground == 0) begin
						state <= FALL;
						fall_counter <= 0;
						dig_counter <= 0;
					end else if (dig_counter == 20) begin
						state <= WALK_LEFT;
						fall_counter <= 0;
						dig_counter <= 0;
					end
				SPLATTER:
					state <= SPLATTER;
					fall_counter <= 0;
					dig_counter <= 0;
			endcase
		end
	end
	
	// Counter increment logic
	always @(posedge clk) begin
		if (areset) begin
			fall_counter <= 0;
		end else begin
			if (ground == 0) begin
				fall_counter <= fall_counter + 1;
			end else begin
				fall_counter <= 0;
			end
			
			if (dig) begin
				dig_counter <= dig_counter + 1;
			end else begin
				dig_counter <= 0;
			end
		end
	end

endmodule
