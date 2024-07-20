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


// Define the states of the Lemming
typedef enum logic [2:0] {
    WALK_LEFT,          // Walking left
    WALK_RIGHT,         // Walking right
    FALLING,            // Falling
    DIGGING,            // Digging
    SPLATTERED          // Splattered
} state_type;

// Define the next state and current state signals
reg [2:0] next_state;
reg [2:0] current_state;

// Define the output signals
assign walk_left = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);
assign aaah = (current_state == FALLING) || (current_state == SPLATTERED);
assign digging = (current_state == DIGGING);

// Define the state machine
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;  // Reset state to walking left
    end else begin
        // Update the current state based on the next state
        current_state <= next_state;
    end
end

// Define the next state logic
always_comb begin
    case (current_state)
        WALK_LEFT: begin
            if (bump_left) begin
                next_state = WALK_RIGHT;  // Switch to walking right if bumped on the left
            end else if (bump_right) begin
                next_state = WALK_LEFT;   // Continue walking left if bumped on the right
            end else if (!ground) begin
                next_state = FALLING;     // Fall if there is no ground
            end else if (dig) begin
                next_state = DIGGING;     // Start digging if allowed
            end else begin
                next_state = WALK_LEFT;   // Continue walking left by default
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_RIGHT;  // Continue walking right if bumped on the left
            end else if (bump_right) begin
                next_state = WALK_LEFT;   // Switch to walking left if bumped on the right
            end else if (!ground) begin
                next_state = FALLING;     // Fall if there is no ground
            end else if (dig) begin
                next_state = DIGGING;     // Start digging if allowed
            end else begin
                next_state = WALK_RIGHT;  // Continue walking right by default
            end
        end
        FALLING: begin
            if (ground) begin
                next_state = current_state;  // Resume walking in the same direction if ground reappears
            end else if (dig) begin
                next_state = current_state;  // Ignore dig command while falling
            end else if (bump_left || bump_right) begin
                 next_state = FALLING;        // Ignore bumps while falling
           end else if (aaah) begin
                 next_state = SPLATTERED;     // Splatter if falling for too long and hit the ground
            end else begin
                next_state = FALLING;        // Continue falling by default
            end
        end
        DIGGING: begin
            if (!ground) begin
                next_state = FALLING;        // Fall if there is no ground while digging
            end else if (dig) begin
                next_state = current_state;  // Ignore dig command while digging
            end else if (bump_left || bump_right) begin
                next_state = DIGGING;        // Ignore bumps while digging
            end else begin
                next_state = DIGGING;        // Continue digging by default
            end
        end
        SPLATTERED: begin
            next_state = SPLATTERED;         // Stay in splattered state forever
        end
        default: begin
            next_state = WALK_LEFT;          // Default to walking left if in unknown state
        end
    endcase
end

endmodule
