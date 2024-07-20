module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            default: next_state = LEFT; // Default to LEFT for safety
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    
endmodule
