module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

// Define states
typedef enum logic [1:0] {
    STATE_WALK_LEFT,
    STATE_WALK_RIGHT
} state_t;

// Declare variables
reg state;
reg walk_left;
reg walk_right;

// Synchronous process
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset the state machine to walk left
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
    end else begin
        case (state)
            STATE_WALK_LEFT: begin
                if (bump_right) begin
                    // If bumped on the right, switch to walking right
                    state <= STATE_WALK_RIGHT;
                    walk_left <= 0;
                    walk_right <= 1;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_left) begin
                    // If bumped on the left, switch to walking left
                    state <= STATE_WALK_LEFT;
                    walk_left <= 1;
                    walk_right <= 0;
                end
            end
        endcase
    end
end

endmodule
