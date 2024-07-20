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

    // State encoding
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
    logic [4:0] fall_counter; // 5 bits counter to count up to 20 cycles

    // State transition logic
    always @(*) begin
        next_state = current_state; // default to hold state
        case (current_state)
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
            FALL_LEFT: begin
                if (ground)
                    next_state = (fall_counter > 20) ? SPLATTER : WALK_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = (fall_counter > 20) ? SPLATTER : WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            SPLATTER: begin
                // Remain in splatter state unless reset
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic: Moore machine outputs are purely based on the state
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (current_state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT,
            FALL_RIGHT: aaah = 1;
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

    // Sequential state updates
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end
        else begin
            if (current_state == SPLATTER) begin
                current_state <= SPLATTER; // Stay in SPLATTER state
            end
            else begin
                current_state <= next_state;
                if (current_state == FALL_LEFT || current_state == FALL_RIGHT) begin
                    if (ground) fall_counter <= 0; // Reset fall counter when ground is detected and shift state
                    else fall_counter <= fall_counter + 1; // Increment fall counter
                end
                else fall_counter <= 0; // Reset fall counter in other states
            end
        end
    end

endmodule
