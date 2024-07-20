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

    // Define the states
    typedef enum logic [2:0] {
        LEFT = 3'b000,      // Walking left
        RIGHT = 3'b001,     // Walking right
        FALL_LEFT = 3'b010, // Falling while previously walking left
        FALL_RIGHT = 3'b011 // Falling while previously walking right
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else if (bump_right)
                    next_state = LEFT; // Continue walking left
                else
                    next_state = LEFT; // Continue walking left without bumps
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else if (bump_left)
                    next_state = RIGHT; // Continue walking right
                else
                    next_state = RIGHT; // Continue walking right without bumps
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT; // Continue falling
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT; // Continue falling
            end
            default: next_state = LEFT; // Default state
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT; // Reset state to walking left
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
