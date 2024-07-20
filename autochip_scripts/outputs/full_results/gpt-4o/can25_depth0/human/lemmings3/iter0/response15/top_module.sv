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

    typedef enum reg [2:0] {WALK_LEFT, WALK_RIGHT, FALL_LEFT, FALL_RIGHT, DIG_LEFT, DIG_RIGHT} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (ground)
                    next_state = (state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = state;
            end
            DIG_LEFT, DIG_RIGHT: begin
                if (!ground)
                    next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
                else
                    next_state = state;
            end
            default: next_state = WALK_LEFT; // Default case to avoid latches
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic based on the current state
    always @(*) begin
        // Default all outputs to 0
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            default: ;
        endcase
    end

endmodule
