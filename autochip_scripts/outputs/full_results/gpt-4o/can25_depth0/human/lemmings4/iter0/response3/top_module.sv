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

    // Define states
    typedef enum {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;
    
    reg [4:0] fall_count;
    reg state_t current_state, next_state;
    
    // Asynchronous reset
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            current_state <= next_state;
            if (!ground && current_state != FALL_LEFT && current_state != FALL_RIGHT && current_state != SPLATTER) begin
                fall_count <= 0; // Reset fall count when starting to fall
            end else if (current_state == FALL_LEFT || current_state == FALL_RIGHT) begin
                fall_count <= fall_count + 1;
            end
        end
    end
    
    // State transition logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (dig && ground) next_state = DIG_LEFT;
                else if (bump_left) next_state = WALK_RIGHT;
                else next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (dig && ground) next_state = DIG_RIGHT;
                else if (bump_right) next_state = WALK_LEFT;
                else next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 20) next_state = SPLATTER;
                    else next_state = WALK_LEFT;
                end else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 20) next_state = SPLATTER;
                    else next_state = WALK_RIGHT;
                end else next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end
    
    // Output logic
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
                default: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end

endmodule
