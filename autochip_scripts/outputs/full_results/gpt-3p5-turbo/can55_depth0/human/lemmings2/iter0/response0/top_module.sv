module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

// Define the states
parameter IDLE = 2'b00;  // Initial state
parameter WALK_LEFT = 2'b01;  // Lemming walking left
parameter WALK_RIGHT = 2'b10;  // Lemming walking right

// Define the current state
reg [1:0] state;

// Define the next state
reg [1:0] next_state;

// Assign the initial state
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
	end
	else begin
		state <= next_state;
	end
end

// Assign the next state based on the current state and inputs
always @(state, bump_left, bump_right, ground) begin
	case(state)
		IDLE: begin
			if (areset) begin
				next_state <= IDLE;
			end
			else if (bump_left) begin
				next_state <= WALK_RIGHT;
			end
			else if (bump_right) begin
				next_state <= WALK_LEFT;
			end
			else begin
				next_state <= IDLE;
			end
		end
		WALK_LEFT: begin
			if (areset) begin
				next_state <= IDLE;
			end
			else if (bump_left) begin
				next_state <= WALK_RIGHT;
			end
			else if (ground == 0) begin
				next_state <= IDLE;
			end
			else begin
				next_state <= WALK_LEFT;
			end
		end
		WALK_RIGHT: begin
			if (areset) begin
				next_state <= IDLE;
			end
			else if (bump_right) begin
				next_state <= WALK_LEFT;
			end
			else if (ground == 0) begin
				next_state <= IDLE;
			end
			else begin
				next_state <= WALK_RIGHT;
			end
		end
		default: begin
			next_state <= IDLE;
		end
	endcase
end

// Assign the outputs based on the current state
always @(state) begin
	case(state)
		IDLE: begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end
		WALK_LEFT: begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end
		WALK_RIGHT: begin
			walk_left <= 1'b0;
			walk_right <= 1'b1;
		end
		default: begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end
	endcase
end

// Assign the aaah output when the Lemming falls
always @(posedge clk or posedge areset) begin
	if (areset) begin
		aaah <= 1'b0;
	end
	else if (ground == 0 && (state == WALK_LEFT || state == WALK_RIGHT)) begin
		aaah <= 1'b1;
	end
	else begin
		aaah <= 1'b0;
	end
end

endmodule
