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

    typedef enum reg [2:0] {
        S_WALK_LEFT,
        S_WALK_RIGHT,
        S_FALL_LEFT,
        S_FALL_RIGHT,
        S_DIG_LEFT,
        S_DIG_RIGHT
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_WALK_LEFT;
        else
            state <= next_state;
    end

    always @(*) begin
        // Default outputs for walking states
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            S_WALK_LEFT: begin
                walk_left = 1;
                if (~ground)
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end
            
            S_WALK_RIGHT: begin
                walk_right = 1;
                if (~ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end
            
            S_FALL_LEFT: begin
                aaah = 1;
                if (ground)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_FALL_LEFT;
            end
            
            S_FALL_RIGHT: begin
                aaah = 1;
                if (ground)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_FALL_RIGHT;
            end
            
            S_DIG_LEFT: begin
                digging = 1;
                if (~ground)
                    next_state = S_FALL_LEFT;
                else
                    next_state = S_DIG_LEFT;
            end
            
            S_DIG_RIGHT: begin
                digging = 1;
                if (~ground)
                    next_state = S_FALL_RIGHT;
                else
                    next_state = S_DIG_RIGHT;
            end
            
            default: next_state = S_WALK_LEFT;
        endcase
    end

endmodule
