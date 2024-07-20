module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLAT
    } state_t;
    
    state_t state, next_state;
    logic [4:0] fall_counter;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
                else next_state = WALK_RIGHT;
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (fall_counter > 20) next_state = SPLAT;
                else if (ground) next_state = (state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
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
            SPLAT: begin
                next_state = SPLAT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT && state != SPLAT);
    assign walk_right = (state == WALK_RIGHT && state != SPLAT);
    assign aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT || state == DIG_RIGHT);

endmodule
