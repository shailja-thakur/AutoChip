module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL_LEFT = 2'b10,
        STATE_FALL_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transitions
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (ground == 0) next_state = STATE_FALL_LEFT;
                else if (bump_left) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (ground == 0) next_state = STATE_FALL_RIGHT;
                else if (bump_right) next_state = STATE_WALK_LEFT;
                else next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT: begin
                if (ground == 1) next_state = STATE_WALK_LEFT;
                else next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                if (ground == 1) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_FALL_RIGHT;
            end
        endcase
    end

    // State update
    always @(posedge clk or posedge areset) begin
        if (areset) current_state <= STATE_WALK_LEFT;
        else current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (current_state)
            STATE_WALK_LEFT: walk_left = 1;
            STATE_WALK_RIGHT: walk_right = 1;
            STATE_FALL_LEFT, STATE_FALL_RIGHT: aaah = 1;
        endcase
    end

endmodule
