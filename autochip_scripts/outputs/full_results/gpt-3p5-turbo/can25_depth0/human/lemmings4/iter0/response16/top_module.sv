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
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_type;
	
	// Define outputs
	logic [4:0] output_state;
	assign {aaah, digging, walk_right, walk_left} = output_state;
	
	// Define current state and next state
	logic        [1:0] current_state;
	logic        [1:0] next_state;
	reg areset_async;
	
	// Define counter for falling duration
	logic [4:0] fall_counter;
	
	// Define parameters
	parameter FALL_THRESHOLD = 20;
	
	// Assign initial values
	always @(posedge clk) begin
		if (areset) begin
			current_state <= WALK_LEFT;
			fall_counter <= 0;
		end else begin
			current_state <= next_state;
		end
		
		areset_async <= areset;
	end
	
	// Define state transition and output logic
	always @(*) begin
		case (current_state)
			WALK_LEFT: begin
				if (areset_async) begin
					next_state = WALK_LEFT;
					output_state = 4'b0001;
				end else if (bump_right) begin
					next_state = WALK_RIGHT;
					output_state = 4'b0010;
				end else if (~ground && !dig) begin
					next_state = FALL;
					output_state = 4'b0100;
				end else if (dig && ground) begin
					next_state = DIG;
					output_state = 4'b1000;
				end else begin
					next_state = WALK_LEFT;
					output_state = 4'b0001;
				end
			end
			
			WALK_RIGHT: begin
				if (areset_async) begin
					next_state = WALK_LEFT;
					output_state = 4'b0001;
				end else if (bump_left) begin
					next_state = WALK_LEFT;
					output_state = 4'b0001;
				end else if (~ground && !dig) begin
					next_state = FALL;
					output_state = 4'b0100;
				end else if (dig && ground) begin
					next_state = DIG;
					output_state = 4'b1000;
				end else begin
					next_state = WALK_RIGHT;
					output_state = 4'b0010;
				end
			end
			
			FALL: begin
				if (areset_async) begin
					next_state = WALK_LEFT;
					output_state = 4'b0001;
				end else if (fall_counter >= FALL_THRESHOLD) begin
					next_state = SPLATTER;
					output_state = 4'b0000;
				end else if (ground && !dig) begin
					next_state = current_state;
					output_state = 4'b0100;
				end else if (dig && ground) begin
					next_state = DIG;
					output_state = 4'b1000;
				end else begin
					next_state = FALL;
					output_state = 4'b0100;
				end
			end
			
			DIG: begin
				if (areset_async) begin
					next_state = WALK_LEFT;
					output_state = 4'b0001;
				end else if (~ground || dig) begin
					next_state = DIG;
					output_state = 4'b1000;
				end else begin
					next_state = current_state;
					output_state = 4'b1000;
				end
			end
			
			SPLATTER: begin
				next_state = SPLATTER;
				output_state = 4'b0000;
			end
			
			default: begin
				next_state = WALK_LEFT;
				output_state = 4'b0001;
			end
		endcase
	end
	
	// Define falling counter increment
	always @(posedge clk) begin
		if (~areset_async && current_state == FALL && fall_counter < FALL_THRESHOLD)
			fall_counter <= fall_counter + 1;
		else
			fall_counter <= 0;
	end
	
endmodule
