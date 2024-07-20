module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic (Moore FSM)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;  // On areset, go to WALK_LEFT state
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT;  // Default state
            end
        endcase
    end

    // Output logic
    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);

endmodule
