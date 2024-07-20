module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);
    
    // State encoding
    typedef enum reg [2:0] {
        LEFT = 3'b000, // Walking left
        RIGHT = 3'b001, // Walking right
        FALL_LEFT = 3'b010, // Falling, was walking left
        FALL_RIGHT = 3'b011 // Falling, was walking right
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        next_state = state; // Default state
        case (state)
            LEFT: begin
                if (~ground) // Fall if ground disappears
                    next_state = FALL_LEFT;
                else if (bump_left) // Switch to right if bump left
                    next_state = RIGHT;
                else if (bump_right) // Keep walking left if bump right
                    next_state = LEFT;
            end
            
            RIGHT: begin
                if (~ground) // Fall if ground disappears
                    next_state = FALL_RIGHT;
                else if (bump_right) // Switch to left if bump right
                    next_state = LEFT;
                else if (bump_left) // Keep walking right if bump left
                    next_state = RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground) // Resume walking left if ground reappears
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT; // Continue falling
            end
            
            FALL_RIGHT: begin
                if (ground) // Resume walking right if ground reappears
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT; // Continue falling
            end
        endcase
    end
    
    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT; // Reset state to walk left
        else
            state <= next_state;
    end
    
    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
