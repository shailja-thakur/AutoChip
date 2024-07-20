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
    // State declaration
    typedef enum logic [2:0] {
        LEFT = 3'b000,    // Walking left state
        RIGHT = 3'b001,   // Walking right state
        FALL_LEFT = 3'b010,  // Falling from left state
        FALL_RIGHT = 3'b011  // Falling from right state
    } state_t;
    
    state_t current_state, next_state;

    // Output logic
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
    assign aaah = (current_state == FALL_LEFT) || (current_state == FALL_RIGHT);

    // State transitions
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (!ground) next_state = FALL_LEFT;
                else if (bump_left || bump_right) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT: begin
                if (!ground) next_state = FALL_RIGHT;
                else if (bump_left || bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground) next_state = LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) next_state = RIGHT;
                else next_state = FALL_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) current_state <= LEFT;
        else current_state <= next_state;
    end

endmodule
