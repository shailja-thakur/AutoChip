module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    
    // State encoding
    typedef enum reg {
        WALK_LEFT = 1'b0,
        WALK_RIGHT = 1'b1
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;  // Reset to WALK_LEFT state
        else
            state <= next_state;
    end
    
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT;  // Default state
        endcase
    end
    
    always_comb begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end

endmodule
