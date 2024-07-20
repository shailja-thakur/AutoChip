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

    // Define the states
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        AA = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT; // Reset state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end

            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end

            default: begin
                next_state = state; // Should not reach here
            end
        endcase
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);

endmodule
