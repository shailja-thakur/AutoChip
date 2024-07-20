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

    typedef enum reg [2:0] {
        LEFT  = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011
    } state_t;

    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left || (bump_left && bump_right))
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_right || (bump_left && bump_right))
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
            end

            default: next_state = LEFT; // default state on reset
        endcase
    end

    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Outputs
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
