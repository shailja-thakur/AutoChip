module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    typedef enum reg {LEFT, RIGHT} state_t;
    state_t state, next_state;

    // State transition logic (Moore FSM)
    always @(*) begin
        case (state)
            LEFT: 
                if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            RIGHT:
                if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            default:
                next_state = LEFT;
        endcase
    end

    // Output logic (Moore FSM)
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
    end

    // State register with async reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

endmodule
