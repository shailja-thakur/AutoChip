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
        LEFT = 1'b0,
        RIGHT = 1'b1
    } state_t;

    state_t state, next_state;

    // State register logic with asynchronous reset
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
            default: next_state = LEFT;
        endcase
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
