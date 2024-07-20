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
    // State definitions
    typedef enum logic[2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT
    } state_t;
    
    // Registers for the current state and next state
    reg [2:0] current_state, next_state;
    
    // State transition and output logic
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        digging = 0;
        aaah = 0;
        
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left | bump_right)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
                walk_left = 1;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left | bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
                walk_right = 1;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
                aaah = 1;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
                aaah = 1;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
                digging = 1;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
                digging = 1;
            end
            default: next_state = WALK_LEFT; // Default state
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end
endmodule
