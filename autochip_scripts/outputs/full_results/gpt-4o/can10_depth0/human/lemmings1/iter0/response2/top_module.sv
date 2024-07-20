module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg state, next_state;

    // State encoding
    localparam LEFT = 1'b0, RIGHT = 1'b1;

    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;       // Reset state to LEFT
        else
            state <= next_state;
    end

    // Next State Logic
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
            default: next_state = LEFT;   // Default state is LEFT
        endcase
    end

    // Output Logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
