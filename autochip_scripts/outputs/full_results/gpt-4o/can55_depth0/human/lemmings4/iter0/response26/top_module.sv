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
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL,
        STATE_DIG,
        STATE_SPLATTER
    } state_t;
    
    reg [4:0] fall_count;
    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        // Default values
        next_state = state;
        case (state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL;
                else if (dig)
                    next_state = STATE_DIG;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL;
                else if (dig)
                    next_state = STATE_DIG;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
            end
            STATE_FALL: begin
                if (ground)
                    next_state = (fall_count > 20) ? STATE_SPLATTER : (walk_left ? STATE_WALK_LEFT : STATE_WALK_RIGHT);
            end
            STATE_DIG: begin
                if (!ground)
                    next_state = STATE_FALL;
            end
            STATE_SPLATTER: begin
                // Stay in splatter state forever
                next_state = STATE_SPLATTER;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == STATE_FALL)
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
            STATE_WALK_LEFT: begin
                walk_left = 1;
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1;
            end
            STATE_FALL: begin
                aaah = 1;
            end
            STATE_DIG: begin
                digging = 1;
            end
            STATE_SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
endmodule
