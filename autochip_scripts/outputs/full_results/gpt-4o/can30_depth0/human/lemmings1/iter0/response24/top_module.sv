module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_WALK_LEFT = 2'b01,
        STATE_WALK_RIGHT = 2'b10
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (bump_left) 
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            
            STATE_WALK_RIGHT: begin
                if (bump_right) 
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            
            default: next_state = STATE_WALK_LEFT; // Default state in case of invalid state
        endcase
    end
    
    // Synchronous state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_WALK_LEFT;
        else
            state <= next_state;
    end
    
    // Output logic (Moore machine)
    always @(*) begin
        walk_left = (state == STATE_WALK_LEFT);
        walk_right = (state == STATE_WALK_RIGHT);
    end

endmodule
