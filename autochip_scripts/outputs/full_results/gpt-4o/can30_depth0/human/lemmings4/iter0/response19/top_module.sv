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
        SPLAT = 3'b110
    } state_t;
    
    // State and next state variables
    state_t state, next_state;
    int fall_count;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground && fall_count > 20)
                    next_state = SPLAT;
                else if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground && fall_count > 20)
                    next_state = SPLAT;
                else if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (ground && dig)
                    next_state = DIG_LEFT;
                else
                    next_state = WALK_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (ground && dig)
                    next_state = DIG_RIGHT;
                else
                    next_state = WALK_RIGHT;
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (!ground)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            default: ;
        endcase
    end

endmodule
