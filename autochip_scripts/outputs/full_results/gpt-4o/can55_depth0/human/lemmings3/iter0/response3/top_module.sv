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

    // Define states
    typedef enum reg [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL_LEFT,
        STATE_FALL_RIGHT,
        STATE_DIG_LEFT,
        STATE_DIG_RIGHT
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_WALK_LEFT:
                if (!ground) 
                    next_state = STATE_FALL_LEFT;
                else if (dig) 
                    next_state = STATE_DIG_LEFT;
                else if (bump_left) 
                    next_state = STATE_WALK_RIGHT;
                else 
                    next_state = STATE_WALK_LEFT;

            STATE_WALK_RIGHT:
                if (!ground) 
                    next_state = STATE_FALL_RIGHT;
                else if (dig) 
                    next_state = STATE_DIG_RIGHT;
                else if (bump_right) 
                    next_state = STATE_WALK_LEFT;
                else 
                    next_state = STATE_WALK_RIGHT;

            STATE_FALL_LEFT:
                if (ground) 
                    next_state = STATE_WALK_LEFT;
                else 
                    next_state = STATE_FALL_LEFT;

            STATE_FALL_RIGHT:
                if (ground) 
                    next_state = STATE_WALK_RIGHT;
                else 
                    next_state = STATE_FALL_RIGHT;

            STATE_DIG_LEFT:
                if (!ground) 
                    next_state = STATE_FALL_LEFT;
                else 
                    next_state = STATE_DIG_LEFT;

            STATE_DIG_RIGHT:
                if (!ground) 
                    next_state = STATE_FALL_RIGHT;
                else 
                    next_state = STATE_DIG_RIGHT;

            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_WALK_LEFT;
        else 
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end

            STATE_WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end

            STATE_FALL_LEFT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end

            STATE_FALL_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end

            STATE_DIG_LEFT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end

            STATE_DIG_RIGHT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end

            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
