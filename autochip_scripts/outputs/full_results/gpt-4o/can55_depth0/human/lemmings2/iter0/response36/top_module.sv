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

    // States encoding
    typedef enum logic [2:0] {
        WALK_LEFT  = 3'b000, // Walking left state
        WALK_RIGHT = 3'b001, // Walking right state
        FALL_LEFT  = 3'b010, // Falling from left state
        FALL_RIGHT = 3'b011  // Falling from right state
    } state_t;
    
    state_t state, next_state;
    
    // Output logic
    assign walk_left  = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah       = (state == FALL_LEFT || state == FALL_RIGHT);

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left || (bump_left && bump_right))
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_right || (bump_left && bump_right))
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            default: next_state = WALK_LEFT; // Default case to handle undefined states
        endcase
    end

endmodule
