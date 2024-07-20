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
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALLING_LEFT,
        STATE_FALLING_RIGHT,
        STATE_DIGGING_LEFT,
        STATE_DIGGING_RIGHT,
        STATE_SPLATTER
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            fall_counter <= 0;
        end else begin
            if (ground && fall_counter > 20) begin
                state <= STATE_SPLATTER;
            end else begin
                state <= next_state;

                if (state == STATE_FALLING_LEFT || state == STATE_FALLING_RIGHT) begin
                    if (ground) fall_counter <= 0;
                    else fall_counter <= fall_counter + 1;
                end else begin
                    fall_counter <= 0;
                end
            end
        end
    end

    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (!ground) next_state = STATE_FALLING_LEFT;
                else if (dig) next_state = STATE_DIGGING_LEFT;
                else if (bump_left) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground) next_state = STATE_FALLING_RIGHT;
                else if (dig) next_state = STATE_DIGGING_RIGHT;
                else if (bump_right) next_state = STATE_WALK_LEFT;
                else next_state = STATE_WALK_RIGHT;
            end
            STATE_FALLING_LEFT: begin
                if (ground && fall_counter <= 20) next_state = STATE_WALK_LEFT;
                else if (ground && fall_counter > 20) next_state = STATE_SPLATTER;
                else next_state = STATE_FALLING_LEFT;
            end
            STATE_FALLING_RIGHT: begin
                if (ground && fall_counter <= 20) next_state = STATE_WALK_RIGHT;
                else if (ground && fall_counter > 20) next_state = STATE_SPLATTER;
                else next_state = STATE_FALLING_RIGHT;
            end
            STATE_DIGGING_LEFT: begin
                if (!ground) next_state = STATE_FALLING_LEFT;
                else next_state = STATE_DIGGING_LEFT;
            end
            STATE_DIGGING_RIGHT: begin
                if (!ground) next_state = STATE_FALLING_RIGHT;
                else next_state = STATE_DIGGING_RIGHT;
            end
            STATE_SPLATTER: begin
                next_state = STATE_SPLATTER;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            STATE_WALK_LEFT: walk_left = 1;
            STATE_WALK_RIGHT: walk_right = 1;
            STATE_FALLING_LEFT, STATE_FALLING_RIGHT: aaah = 1;
            STATE_DIGGING_LEFT: digging = 1;
            STATE_DIGGING_RIGHT: digging = 1;
            STATE_SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
