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
        WALK_LEFT = 3'd0,
        WALK_RIGHT = 3'd1,
        FALL_LEFT = 3'd2,
        FALL_RIGHT = 3'd3,
        DIG_LEFT = 3'd4,
        DIG_RIGHT = 3'd5,
        SPLAT = 3'd6
    } state_t;

    state_t state, next_state;

    logic [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLAT;
                    else next_state = WALK_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLAT;
                    else next_state = WALK_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
            end
            SPLAT: begin
                // Remain in SPLAT state forever once entered
            end
            default: next_state = WALK_LEFT; // Should not happen
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
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

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT || state == DIG_RIGHT);

endmodule
