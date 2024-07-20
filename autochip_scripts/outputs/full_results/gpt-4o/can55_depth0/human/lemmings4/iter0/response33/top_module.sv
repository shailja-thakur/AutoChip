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
    // Define state encodings
    typedef enum reg [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011,
        STATE_DIG_LEFT = 3'b100,
        STATE_DIG_RIGHT = 3'b101,
        STATE_SPLATTERED = 3'b110
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_count; // Counter for falling cycles
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_count <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALL_LEFT || current_state == STATE_FALL_RIGHT)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (dig)
                    next_state = STATE_DIG_LEFT;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (dig)
                    next_state = STATE_DIG_RIGHT;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT: begin
                if (ground)
                    next_state = (fall_count > 20) ? STATE_SPLATTERED : STATE_WALK_LEFT;
                else
                    next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                if (ground)
                    next_state = (fall_count > 20) ? STATE_SPLATTERED : STATE_WALK_RIGHT;
                else
                    next_state = STATE_FALL_RIGHT;
            end
            STATE_DIG_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else
                    next_state = STATE_DIG_LEFT;
            end
            STATE_DIG_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else
                    next_state = STATE_DIG_RIGHT;
            end
            STATE_SPLATTERED: begin
                next_state = STATE_SPLATTERED;
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end
    
    // Output logic
    always @(*) begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL_LEFT || current_state == STATE_FALL_RIGHT);
        digging = (current_state == STATE_DIG_LEFT || current_state == STATE_DIG_RIGHT);
    end

endmodule
