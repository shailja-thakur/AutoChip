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
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        FALL_DIG_LEFT = 3'b110,
        FALL_DIG_RIGHT = 3'b111
    } state_t;

    state_t state, next_state;

    // State transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (~ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
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
            DIG_LEFT: begin
                if (~ground) next_state = FALL_DIG_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (~ground) next_state = FALL_DIG_RIGHT;
                else next_state = DIG_RIGHT;
            end
            FALL_DIG_LEFT: begin
                if (ground) next_state = LEFT;
                else next_state = FALL_DIG_LEFT;
            end
            FALL_DIG_RIGHT: begin
                if (ground) next_state = RIGHT;
                else next_state = FALL_DIG_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            FALL_DIG_LEFT: aaah = 1;
            FALL_DIG_RIGHT: aaah = 1;
        endcase
    end

endmodule
