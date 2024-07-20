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

    // Define states
    typedef enum reg [2:0] {
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_WALK_LEFT;
        else
            state <= next_state;
    end

    // Combinational logic for next state decision and outputs
    always @(*) begin
        // Defaults
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        next_state = state;

        case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (bump_left || bump_right)
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_WALK_RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (bump_left || bump_right)
                    next_state = STATE_WALK_LEFT;
            end
            STATE_FALL_LEFT: begin
                aaah = 1;
                if (ground)
                    next_state = STATE_WALK_LEFT;
            end
            STATE_FALL_RIGHT: begin
                aaah = 1;
                if (ground)
                    next_state = STATE_WALK_RIGHT;
            end
        endcase
    end
endmodule
