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
        FALLING_LEFT,
        FALLING_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_counter; // 5-bit counter to count up to at least 20 clock cycles

    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) next_state = FALLING_LEFT;
                else if (dig) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALLING_RIGHT;
                else if (dig) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
                else next_state = WALK_RIGHT;
            end
            FALLING_LEFT: begin
                if (ground) begin
                    if (fall_counter >= 20) next_state = SPLATTERED;
                    else next_state = WALK_LEFT;
                end
                else next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground) begin
                    if (fall_counter >= 20) next_state = SPLATTERED;
                    else next_state = WALK_RIGHT;
                end
                else next_state = FALLING_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALLING_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALLING_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLATTERED: begin
                next_state = SPLATTERED; // Lemming remains splattered
            end
            default: next_state = WALK_LEFT; // Default to WALK_LEFT state
        endcase
    end

    // State register and fall counter update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end
        else begin
            current_state <= next_state;

            if (current_state == FALLING_LEFT || current_state == FALLING_RIGHT) 
                fall_counter <= fall_counter + 1;
            else 
                fall_counter <= 0; // Reset fall counter on ground
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALLING_LEFT: aaah = 1;
            FALLING_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLATTERED: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
