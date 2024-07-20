module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    // Define states
    typedef enum logic [1:0] {
        LEFT = 2'd0,
        RIGHT = 2'd1
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            LEFT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            default: next_state = LEFT;  // Default case
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    
endmodule
