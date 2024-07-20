module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

// Define the states of the Lemming
typedef enum logic [1:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL
} State;

// Define the state register
logic [1:0] current_state, next_state;

// Define outputs
logic walk_left, walk_right, aaah;

// Define the state transition logic
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT; // Reset to walk left state
    end else begin
        current_state <= next_state; // Update state to next state
    end
end

// Define the next state logic
always_comb begin
    next_state = current_state;
    case (current_state)
        WALK_LEFT:
            if (bump_left && !bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!bump_left && bump_right) begin
                next_state = WALK_LEFT;
            end else if (bump_left && bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALL;
            end
        WALK_RIGHT:
            if (!bump_left && bump_right) begin
                next_state = WALK_LEFT;
            end else if (bump_left && !bump_right) begin
                next_state = WALK_RIGHT;
            end else if (bump_left && bump_right) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALL;
            end
        FALL:
            if (ground) begin
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (current_state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end
    endcase
end

// Define the output logic
always_comb begin
    case (current_state)
        WALK_LEFT:
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
        WALK_RIGHT:
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
        FALL:
            walk_left = (current_state == WALK_LEFT) ? 1 : 0;
            walk_right = (current_state == WALK_RIGHT) ? 1 : 0;
            aaah = 1;
    endcase
end

endmodule
