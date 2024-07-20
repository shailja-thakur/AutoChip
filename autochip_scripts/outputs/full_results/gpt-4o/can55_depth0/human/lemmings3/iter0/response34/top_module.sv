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

    typedef enum logic [2:0] {
        LEFT    = 3'b000,  // Walking left
        RIGHT   = 3'b001,  // Walking right
        FALL    = 3'b010,  // Falling
        DIGLEFT = 3'b011,  // Digging while walking left
        DIGRIGHT= 3'b100   // Digging while walking right
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground)                next_state = FALL;
                else if (dig)               next_state = DIGLEFT;
                else if (bump_left)         next_state = RIGHT;
                else if (bump_right)        next_state = LEFT;
                else                        next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)                next_state = FALL;
                else if (dig)               next_state = DIGRIGHT;
                else if (bump_right)        next_state = LEFT;
                else if (bump_left)         next_state = RIGHT;
                else                        next_state = RIGHT;
            end
            FALL: begin
                if (ground) begin
                    if (state == LEFT || state == DIGLEFT)   next_state = LEFT;
                    else                                     next_state = RIGHT;
                end else                     next_state = FALL;
            end
            DIGLEFT: begin
                if (~ground)                next_state = FALL;
                else                        next_state = DIGLEFT;
            end
            DIGRIGHT: begin
                if (~ground)                next_state = FALL;
                else                        next_state = DIGRIGHT;
            end
            default:                        next_state = LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            LEFT: begin
                walk_left = 1;
            end
            RIGHT: begin
                walk_right = 1;
            end
            FALL: begin
                aaah = 1;
            end
            DIGLEFT: begin
                digging = 1;
                walk_left = 1;  // Still walking left while digging
            end
            DIGRIGHT: begin
                digging = 1;
                walk_right = 1; // Still walking right while digging
            end
        endcase
    end
endmodule
