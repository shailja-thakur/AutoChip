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
        S_LEFT  = 2'b00,
        S_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic (Moore FSM)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S_LEFT: begin
                if (bump_left) begin
                    next_state = S_RIGHT;
                end else begin
                    next_state = S_LEFT;
                end
            end
            S_RIGHT: begin
                if (bump_right) begin
                    next_state = S_LEFT;
                end else begin
                    next_state = S_RIGHT;
                end
            end
            default: begin
                next_state = S_LEFT; // default state
            end
        endcase
    end

    // Output logic
    assign walk_left = (current_state == S_LEFT);
    assign walk_right = (current_state == S_RIGHT);

endmodule
