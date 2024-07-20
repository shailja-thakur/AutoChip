module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define state encoding
    typedef enum reg {LEFT, RIGHT} state_t;
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left || bump_right)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (bump_left || bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            default: next_state = LEFT; // Default state
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT; // Reset to walk left
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
    end

endmodule
