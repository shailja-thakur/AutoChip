module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    // State encoding
    typedef enum logic [1:0] {
        LEFT  = 2'b00,
        RIGHT = 2'b01,
        FALL  = 2'b10
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;  // Default assignment
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL;
                else if (bump_left)
                    next_state = RIGHT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL;
                else if (bump_right)
                    next_state = LEFT;
            end
            FALL: begin
                if (ground)
                    next_state = (next_state == LEFT) ? LEFT : RIGHT; // Maintain walking direction after fall
            end
        endcase
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL);

endmodule
