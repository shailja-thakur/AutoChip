module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define state encoding
    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            LEFT: begin
                if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            default: next_state = LEFT;
        endcase
    end

    // Output logic
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);

endmodule
