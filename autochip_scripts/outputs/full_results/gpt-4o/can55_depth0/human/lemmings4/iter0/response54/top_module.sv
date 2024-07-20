module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    // State encodings
    typedef enum reg [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011,
        STATE_DIG_LEFT = 3'b100,
        STATE_DIG_RIGHT = 3'b101,
        STATE_SPLATTER = 3'b110
    } state_t;

    state_t state, next_state;
    reg [4:0] fall_counter; // 5-bit counter for counting up to 20 clock cycles

    // Output logic
    assign walk_left  = (state == STATE_WALK_LEFT);
    assign walk_right = (state == STATE_WALK_RIGHT);
    assign aaah       = (state == STATE_FALL_LEFT) || (state == STATE_FALL_RIGHT);
    assign digging    = (state == STATE_DIG_LEFT) || (state == STATE_DIG_RIGHT);

    // State transitions
    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (dig && ground)
                    next_state = STATE_DIG_LEFT;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (dig && ground)
                    next_state = STATE_DIG_RIGHT;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT,
            STATE_FALL_RIGHT: begin
                if (fall_counter > 20)
                    next_state = STATE_SPLATTER;
                else if (ground)
                    next_state = (state == STATE_FALL_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                else
                    next_state = state;
            end
            STATE_DIG_LEFT,
            STATE_DIG_RIGHT: begin
                if (!ground)
                    next_state = (state == STATE_DIG_LEFT) ? STATE_FALL_LEFT : STATE_FALL_RIGHT;
                else
                    next_state = state;
            end
            STATE_SPLATTER: begin
                next_state = STATE_SPLATTER; // Stay splattered
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // Fall counter logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            fall_counter <= 0;
        else if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT)
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end

    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= STATE_WALK_LEFT;
        else
            state <= next_state;
    end

endmodule
