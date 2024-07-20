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
    // State declarations
    typedef enum {LEFT, RIGHT, FALL_LEFT, FALL_RIGHT, DIG_LEFT, DIG_RIGHT, SPLAT} state_t;
    state_t state, next_state;
    reg [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground && fall_counter > 20) next_state = SPLAT;
                else if (ground) next_state = LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground && fall_counter > 20) next_state = SPLAT;
                else if (ground) next_state = RIGHT;
                else next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end
        else begin
            if (ground) begin // Only update state when on ground
                state <= next_state;
                fall_counter <= 0;
            end 
            else begin
                state <= next_state;
                // Increment fall counter while falling
                if (state == FALL_LEFT || state == FALL_RIGHT)
                    fall_counter <= fall_counter + 1;
            end
        end
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
            FALL_LEFT, FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
