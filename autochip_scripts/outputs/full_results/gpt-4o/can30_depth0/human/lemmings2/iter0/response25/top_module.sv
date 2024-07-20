module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALLING_LEFT = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            LEFT: begin
                if (~ground) 
                    next_state = FALLING_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)
                    next_state = FALLING_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALLING_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALLING_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    always_comb begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALLING_LEFT) || (state == FALLING_RIGHT);
    end

endmodule
