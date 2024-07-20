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

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
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
            default: next_state = LEFT;  // Safe default state
        endcase
    end

    // Output logic
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);

endmodule
