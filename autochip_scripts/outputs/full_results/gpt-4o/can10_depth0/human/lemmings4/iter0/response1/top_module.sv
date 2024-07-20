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
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;
    
    state_t current_state, next_state;
    reg [4:0] fall_count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL_LEFT || current_state == FALL_RIGHT) 
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    always @(*) begin
        case (current_state)
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
            FALL_LEFT, FALL_RIGHT: begin
                if (fall_count > 20)
                    next_state = SPLATTER;
                else if (ground)
                    next_state = (current_state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
                else
                    next_state = current_state;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (current_state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
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
