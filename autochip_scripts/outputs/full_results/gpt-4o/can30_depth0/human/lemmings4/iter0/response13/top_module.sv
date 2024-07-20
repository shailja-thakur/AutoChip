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
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to no state change
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT; // Start falling
                else if (dig)
                    next_state = DIG_LEFT; // Start digging
                else if (bump_left)
                    next_state = WALK_RIGHT; // Switch to walking right
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT; // Start falling
                else if (dig)
                    next_state = DIG_RIGHT; // Start digging
                else if (bump_right)
                    next_state = WALK_LEFT; // Switch to walking left
            end
            FALL_LEFT: begin
                if (ground && fall_counter > 20)
                    next_state = SPLATTER; // Splatter on hard ground
                else if (ground)
                    next_state = WALK_LEFT; // Recover from fall
            end
            FALL_RIGHT: begin
                if (ground && fall_counter > 20)
                    next_state = SPLATTER; // Splatter on hard ground
                else if (ground)
                    next_state = WALK_RIGHT; // Recover from fall
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT; // Start falling
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT; // Start falling
            end
            SPLATTER: begin
                // Remain in splatter state
            end
        endcase
    end

    // State updating logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (aaah)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;
            end
            WALK_RIGHT: begin
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
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
