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
        STATE_LEFT  = 2'b01,
        STATE_RIGHT = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_LEFT;  // Asynchronous reset to walk_left
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_LEFT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = STATE_RIGHT;  // Switch to right
                else
                    next_state = STATE_LEFT;  // Stay left
            end
            STATE_RIGHT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = STATE_LEFT;  // Switch to left
                else
                    next_state = STATE_RIGHT;  // Stay right
            end
            default: begin
                next_state = STATE_LEFT;  // Default state
            end
        endcase
    end

    // Output logic
    assign walk_left = (state == STATE_LEFT);
    assign walk_right = (state == STATE_RIGHT);

endmodule
