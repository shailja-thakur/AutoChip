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

    // State definitions
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to handle up to 20 cycles

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            if (aaah) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to the current state
        
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end

            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end

            FALL_LEFT, FALL_RIGHT: begin
                if (ground && fall_counter > 20)
                    next_state = SPLATTER;
                else if (ground)
                    next_state = (state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
            end

            DIG_LEFT, DIG_RIGHT: begin
                if (!ground)
                    next_state = (state == DIG_LEFT) ? FALL_LEFT : FALL_RIGHT;
            end

            SPLATTER: begin
                next_state = SPLATTER; // Remains in SPLATTER state forever
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic: Moore outputs depend only on the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;

            case (state)
                WALK_LEFT: walk_left <= 1;
                WALK_RIGHT: walk_right <= 1;
                FALL_LEFT, FALL_RIGHT: aaah <= 1;
                DIG_LEFT, DIG_RIGHT: digging <= 1;
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
