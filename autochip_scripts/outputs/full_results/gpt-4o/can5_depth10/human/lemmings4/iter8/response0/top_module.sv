module top_module(
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

    typedef enum {LEFT, RIGHT, FALL_LEFT, FALL_RIGHT, DIG_LEFT, DIG_RIGHT, SPLAT} state_t;
    state_t state, next_state;
    reg [4:0] fall_counter;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left | bump_right) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_left | bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (ground && fall_counter >= 20) next_state = SPLAT;
                else if (ground) next_state = (state == FALL_LEFT) ? LEFT : RIGHT;
                else next_state = state;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLAT: next_state = SPLAT;
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (fall_counter < 20 && !ground)
                    fall_counter <= fall_counter + 1;
            end
            else
                fall_counter <= 0;
        end
    end

    // Output logic (combinational)
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLAT: {walk_left, walk_right, aaah, digging} = 4'b0000;
        endcase
    end

endmodule
