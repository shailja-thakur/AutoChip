module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    // States definition
    typedef enum reg [1:0] {
        STATE_LEFT = 2'b00,
        STATE_RIGHT = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // Next state logic
    always @(*) begin
        case (state)
            STATE_LEFT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_LEFT;
            end
            STATE_RIGHT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_RIGHT;
            end
            default: next_state = STATE_LEFT; // Default case
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_LEFT;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        walk_left = (state == STATE_LEFT);
        walk_right = (state == STATE_RIGHT);
    end
    
endmodule
