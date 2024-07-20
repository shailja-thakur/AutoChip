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
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_count;

    // State transition
    always @(*)
    begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground) next_state = FALLING;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALLING;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
            end
            FALLING: begin
                if (fall_count >= 5'd20 && ground) next_state = SPLATTER;
                else if (ground) next_state = (state == WALK_LEFT || state == DIG_LEFT) ? WALK_LEFT : WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALLING;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALLING;
            end
            SPLATTER: begin
                // Remain in splatter state forever
            end
            default: next_state = WALK_LEFT; // Default state
        endcase
    end

    // State register update
    always @(posedge clk or posedge areset)
    begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALLING || next_state == FALLING) fall_count <= fall_count + 5'd1;
            else fall_count <= 5'd0;
        end
    end

    // Output logic
    always @(*)
    begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALLING: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
