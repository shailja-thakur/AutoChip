module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT; // Upon reset, start walking left
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            LEFT: begin
                if (bump_left)
                    next_state = RIGHT; // Bumped on the left, switch to walking right
                else if (bump_right)
                    next_state = LEFT; // Bumped on the right, switch to walking left
                else
                    next_state = LEFT; // Continue walking left
            end
            RIGHT: begin
                if (bump_left)
                    next_state = RIGHT; // Bumped on the left, switch to walking right
                else if (bump_right)
                    next_state = LEFT; // Bumped on the right, switch to walking left
                else
                    next_state = RIGHT; // Continue walking right
            end
        endcase
    end
    
    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
