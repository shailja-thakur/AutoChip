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

    // Enumerate states
    typedef enum reg [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALLING_LEFT = 3'b010,
        FALLING_RIGHT = 3'b011,
        FALLING = 3'b100  // Generic fall state for simplicity
    } state_t;

    state_t state, next_state;

    // State transition logic (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        // Default values for outputs and next_state
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        next_state = state;

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end
            FALLING_LEFT: begin
                aaah = 1;
                if (ground)
                    next_state = WALK_LEFT;
            end
            FALLING_RIGHT: begin
                aaah = 1;
                if (ground)
                    next_state = WALK_RIGHT;
            end
            FALLING: begin
                aaah = 1;
                if (ground)
                    next_state = previous_state;  // Variable to store the prior state to decide direction
            end
            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end

    // Remember the previous non-falling state for proper recovery
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            previous_state <= WALK_LEFT;
        else if (!ground)
            previous_state <= state;
    end

endmodule
