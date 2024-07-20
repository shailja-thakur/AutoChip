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

    // State encoding
    typedef enum reg [2:0] {
        LEFT    = 3'b000,
        RIGHT   = 3'b001,
        FALL_L  = 3'b010,
        FALL_R  = 3'b011,
        DIG_L   = 3'b100,
        DIG_R   = 3'b101,
        FALL_D_L = 3'b110,
        FALL_D_R = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            LEFT: begin
                if (~ground)      next_state = FALL_L;
                else if (dig)     next_state = DIG_L;
                else if (bump_left || bump_right) next_state = RIGHT;
                else              next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)      next_state = FALL_R;
                else if (dig)     next_state = DIG_R;
                else if (bump_left || bump_right) next_state = LEFT;
                else              next_state = RIGHT;
            end
            DIG_L: begin
                if (~ground)      next_state = FALL_D_L;
                else              next_state = DIG_L;
            end
            DIG_R: begin
                if (~ground)      next_state = FALL_D_R;
                else              next_state = DIG_R;
            end
            FALL_L: begin
                if (ground)       next_state = LEFT;
                else              next_state = FALL_L;
            end
            FALL_R: begin
                if (ground)       next_state = RIGHT;
                else              next_state = FALL_R;
            end
            FALL_D_L: begin
                if (ground)       next_state = LEFT;
                else              next_state = FALL_D_L;
            end
            FALL_D_R: begin
                if (ground)       next_state = RIGHT;
                else              next_state = FALL_D_R;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case(state)
            LEFT:    walk_left = 1;
            RIGHT:   walk_right = 1;
            FALL_L:  aaah = 1;
            FALL_R:  aaah = 1;
            DIG_L:   digging = 1;
            DIG_R:   digging = 1;
            FALL_D_L: aaah = 1;
            FALL_D_R: aaah = 1;
        endcase
    end

endmodule
