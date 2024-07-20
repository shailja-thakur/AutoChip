module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    // State Encoding
    typedef enum logic {LEFT, RIGHT} state_t;
    state_t state, next_state;
    
    // State Transition (Next State Logic)
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            default: next_state = LEFT; // Default state
        endcase
    end
    
    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Output Logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    
endmodule
