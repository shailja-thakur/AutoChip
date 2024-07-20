module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    // State definition
    typedef enum logic [1:0] {
        LEFT = 2'b01,
        RIGHT = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    
    // Asynchronous reset and state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT; // Initialize to walk left on reset
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case(current_state)
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
            default: next_state = LEFT; // Default to walking left
        endcase
    end
    
    // Output logic
    always @(*) begin
        case(current_state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule
