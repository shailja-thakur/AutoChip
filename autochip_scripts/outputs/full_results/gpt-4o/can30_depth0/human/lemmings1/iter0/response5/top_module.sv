module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    parameter LEFT = 1'b0, RIGHT = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            default: next_state = LEFT; // Default state
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
    always @(*) begin
        walk_left = (state == LEFT) ? 1'b1 : 1'b0;
        walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
    end

endmodule
