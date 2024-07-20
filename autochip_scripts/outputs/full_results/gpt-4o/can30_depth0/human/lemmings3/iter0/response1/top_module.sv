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

    // Define state encoding
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_DIGGING_LEFT = 3'b010,
        S_DIGGING_RIGHT = 3'b011,
        S_AAAH_LEFT = 3'b100,
        S_AAAH_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            S_WALK_LEFT: begin
                if (!ground) next_state = S_AAAH_LEFT;
                else if (dig) next_state = S_DIGGING_LEFT;
                else if (bump_left) next_state = S_WALK_RIGHT;
            end
            S_WALK_RIGHT: begin
                if (!ground) next_state = S_AAAH_RIGHT;
                else if (dig) next_state = S_DIGGING_RIGHT;
                else if (bump_right) next_state = S_WALK_LEFT;
            end
            S_DIGGING_LEFT: begin
                if (!ground) next_state = S_AAAH_LEFT;
            end
            S_DIGGING_RIGHT: begin
                if (!ground) next_state = S_AAAH_RIGHT;
            end
            S_AAAH_LEFT: begin
                if (ground) next_state = S_WALK_LEFT;
            end
            S_AAAH_RIGHT: begin
                if (ground) next_state = S_WALK_RIGHT;
            end
        endcase
    end

    // State register logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == S_WALK_LEFT);
    assign walk_right = (state == S_WALK_RIGHT);
    assign digging = (state == S_DIGGING_LEFT || state == S_DIGGING_RIGHT);
    assign aaah = (state == S_AAAH_LEFT || state == S_AAAH_RIGHT);

endmodule
