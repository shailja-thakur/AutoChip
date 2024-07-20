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

    // State identifiers
    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALL_LEFT = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) next_state = LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = RIGHT;
                else next_state = FALL_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    end

endmodule
