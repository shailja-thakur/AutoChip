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

    // State transition logic
    always @(*) begin
        // Default next state is the current state
        next_state = state;
        case (state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = RIGHT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = LEFT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter >= 20) next_state = SPLAT;
                    else next_state = LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter >= 20) next_state = SPLAT;
                    else next_state = RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = LEFT;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end

    // Output logic
    always @(*) begin
        // Default all outputs to 0
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
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;
            end
            DIG_LEFT: begin
                digging = 1;
            end
            DIG_RIGHT: begin
                digging = 1;
            end
            SPLAT: begin
                // All outputs remain 0
            end
        endcase
    end

endmodule
