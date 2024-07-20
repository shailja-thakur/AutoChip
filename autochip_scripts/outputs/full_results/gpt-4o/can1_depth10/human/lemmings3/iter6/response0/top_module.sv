module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    typedef enum reg [2:0] {
        LEFT,       // walking left
        RIGHT,      // walking right
        FALL,       // falling from either direction
        DIG_LEFT,   // digging from walking left
        DIG_RIGHT   // digging from walking right
    } state_t;

    state_t state, next_state;
    state_t prev_walk_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL: begin
                if (ground)
                    next_state = prev_walk_state;
                else
                    next_state = FALL;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else
                    next_state = DIG_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            prev_walk_state <= LEFT;
        end else begin
            if (state == LEFT || state == RIGHT) begin
                prev_walk_state <= state;
            end
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left  = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah       = (state == FALL);
        digging    = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end
endmodule
