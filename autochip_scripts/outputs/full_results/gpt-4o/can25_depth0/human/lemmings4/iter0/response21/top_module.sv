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

    // State Declaration
    typedef enum reg [3:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter;

    // State Transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else if (ground && (state != DIG_LEFT && state != DIG_RIGHT)) begin
                fall_counter <= 0;
            end
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = state; // Default state
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left || bump_right) next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_left || bump_right) next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLATTER;
                    else next_state = WALK_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20) next_state = SPLATTER;
                    else next_state = WALK_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
            end
            SPLATTER: begin
                // remain in SPLATTER state
            end
        endcase
    end

    // Output Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (next_state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
                FALL_LEFT, FALL_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                SPLATTER: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end

endmodule
