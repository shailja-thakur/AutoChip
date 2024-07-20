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
    typedef enum {LEFT, RIGHT, FALL_LEFT, FALL_RIGHT} state_t;
    state_t state, next_state;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else 
                    next_state = LEFT;
            end
            
            RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else 
                    next_state = RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground) 
                    next_state = LEFT;
                else 
                    next_state = FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                if (ground) 
                    next_state = RIGHT;
                else 
                    next_state = FALL_RIGHT;
            end
            
            default: next_state = LEFT; // Default state
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (state)
            LEFT: begin
                walk_left = 1;
                aaah = 0;
            end
            RIGHT: begin
                walk_right = 1;
                aaah = 0;
            end
            FALL_LEFT: begin
                walk_left = 0;
                aaah = 1;
            end
            FALL_RIGHT: begin
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end
endmodule
